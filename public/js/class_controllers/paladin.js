var init = function() {

	// I was proud of this piece of code. The CreateJS library didn't like
	// running animations by percentages and required pixels to work,
	// so I had to essentially get the size of the element I can rendering to
	// and set it to a pixel width and height value as opposed to a percentage-based
	// size.

	var setCanvas = function() {
		canvasWidth = document.getElementById("overlay").offsetWidth
		canvasHeight = document.getElementById("overlay").offsetHeight
		$("canvas").css("visibility", "visible");
		$("canvas").remove();
		$("body").append("<canvas id='overlay' height='"+canvasHeight+"' width='"+canvasWidth+"' z-index='99999'></canvas>");
	}

	// Method I used to generate as many bitmap objects as I liked.
	var createBitmapObject = function(name, number, image) {
		var container = Array();
		for (i = 0; i < number; i++) {
				container.push(new createjs.Bitmap(image));
		}
		return container
	}

	// This project didn't require me to pass an ID to the backend, as
	// all of the information I needed to find objects in the database was either in the
	// session or on th user model already. I was relying on the server returning
	// the newly ammended objects so I could use the callback function 'done' to 
	// make changes on the front end. It was a very crude implementation, but it worked
	// nonetheless. 
	var playerAttack = function() {
	$(".attack").on("click", function(event){
	event.preventDefault();
	autoAttack();

	$.ajax({
		url: "/battle/attack",
		type: "PUT"
	}).done(function(data){
		if (data === "\"win\""){
			$(".win").css("visibility", "visible");
		}
		else {
			data = $.parseJSON(data)
			console.log(data)
			//0 is enemy, 1 is character
			$(".current-special").css("width", data[1].special + "%")
			$(".char-special").html("" + data[1].special);
			$(".enemy-hp").html("" + data[0].current_hp);
			$(".enemy-current-health").css("width", ((data[0].current_hp/data[0].max_hp)*100) +"%");
			enemyAttack();
				if (data[1].special >= 100){
					$(".special").css("visibility", "visible")
				}
				else {
					$(".special").css("visibility", "hidden")
				}
		}
	})
})};

var playerBrace = function () {
	$(".defend").on("click", function(event){
		event.preventDefault();

		$.ajax({
			url:"/battle/brace",
			type: "PUT"
		}).done(function(character){
					if (data === "\"lose\""){
			$(".loss").css("visibility", "visible");
			}
			else{
			character = $.parseJSON(character)
			$(".current-special").css("width", character.special + "%");
			$(".current-health").css("width", ((character.current_hp/character.max_hp)*100) +"%");
			$(".char-hp").html("" + Math.floor(character.current_hp));
			$(".char-special").html("" + character.special);
				if (character.special >= 100){
					$(".special").css("visibility", "visible")
				}
				else {
					$(".special").css("visibility", "hidden")
				}			
		}})
	})
}

// Similar to the character version. The main issue with the way that this was
// implemented on the server side was really funky. I had the character always attack
// first, and then this method would get called after the DOM elements got updated.
// So, in all reality, there was only one piece of turn functionality and it relied on
// the user taking an action first. Not a clean implementation of attack-and-defend
// functionality, but not a bad first attempt. 
var enemyAttack = function() {
		$.ajax({
		url: "/battle/defend",
		type: "PUT"
	}).done(function(character){
		if (character === "\"lose\""){
			console.log(character)
			$(".loss").css("visibility", "visible");
		}
		else {
			console.log(character)
			character = $.parseJSON(character)
			$(".current-health").css("width", ((character.current_hp/character.max_hp)*100) +"%");
			$(".char-hp").html("" + Math.floor(character.current_hp));
		}
	})
}

var playerSpecial = function () {
	$(".special").on("click", function(event){
	event.preventDefault();

	$.ajax({
		url: "/battle/special",
		type: "PUT"
	}).done(function(data){
		if (data === "\"win\""){	
			judgement();
			$(".win").css("visibility", "visible");
		}
		else {
			console.log(data)
			data = $.parseJSON(data)
			console.log(data)
			//0 is enemy, 1 is character
			$(".enemy-hp").html("" + data[0].current_hp); 
			$(".enemy-current-health").css("width", ((data[0].current_hp/data[0].max_hp)*100) +"%");
			$(".current-special").css("width", data[1].special + "%");
			$(".char-special").html("" + data[1].special);
			$(".special").css("visibility", "hidden")
			judgement();
			enemyAttack();
		}
	})
})};

// Similar to the attack and brace functions. I just now realized that the 
// site redirects you to the localhost server instead of just taking you to 
// /main or something. Oops. 
var playerRun = function(){
	$('.run').on("click", function(event){
		event.preventDefault();

		console.log("hitting")
		$.ajax({
			url: '/battle/run',
			type: 'put'
		}).done(function(data){
			data = $.parseJSON(data);

			console.log(data)

			if(data == 'success'){
				window.location = "http://localhost:9393/main";
			}
			else{
				alert("Escape failed!")
				enemyAttack();
			}
		})

	})
}

// This is the animation for the special attack. This caucophony
// essentially sets the positions of the bitmap objects then executes the animations
// in order. It is a ton of code, but the animations actually turned out nicely.
// I do seem to remember a big with this animation in particular where the canvas would
// constantly try to update or something and consequently caused this errorthat would
// tick 60 times per second. I couldn't figure it out, and my instructors didn't knw anything
// about how CreateJS worked. I left it, as you could get the first animations to run. Anything
// after that would stick it in the loop, though. 
var judgement = function() {

	setCanvas();

	var stage = new createjs.Stage("overlay");

	var holySword = new createjs.Bitmap('/css/images/holy-sword.png')
		holySword.regX = 200
		holySword.regY = 100
		holySword.x = canvasWidth * .85
		holySword.y = -300
		stage.addChild(holySword)

	var holySword2 = new createjs.Bitmap('/css/images/holy-sword.png')
		holySword2.regX = 200
		holySword2.regY = 100
		holySword2.x = canvasWidth * 1.40
		holySword2.y = -300
		stage.addChild(holySword2)

	var holySword3 = new createjs.Bitmap('/css/images/holy-sword.png')
		holySword3.regX = 200
		holySword3.regY = 100
		holySword3.x = canvasWidth * .40
		holySword3.y = -300
		stage.addChild(holySword3)

	var one = function(){
		$.each(holySword, function(i, arrow){
			holySword.rotation = 270
			createjs.Tween.get(holySword, {loop: false})
				.to({x: canvasWidth * .83, y:300}, 500, createjs.Ease.circIn)
				.to({alpha: 0}, 2400)

			createjs.Ticker.setFPS(60);
			createjs.Ticker.addEventListener("tick", this.stage);
		})
	}

	var two = function(){
		$.each(holySword2, function(i, arrow){
			holySword2.rotation = 315
			createjs.Tween.get(holySword2, {loop: false})
				.to({x: canvasWidth * .83, y:372}, 700, createjs.Ease.circIn)
				.to({alpha: 0}, 2600)

			createjs.Ticker.setFPS(60);
			createjs.Ticker.addEventListener("tick", this.stage);
		})
	}

var three = function() {
		$.each(holySword3, function(i, arrow){
		holySword3.rotation = 225
		createjs.Tween.get(holySword3, {loop: false})
			.to({x: canvasWidth * .80, y:300}, 900, createjs.Ease.circIn)
			.to({alpha: 0}, 2800)

		createjs.Ticker.setFPS(60);
		createjs.Ticker.addEventListener("tick", this.stage);

		})
	}

	one();
	two();
	three();
}

// This is the clean animation for shooting an arrow. I didn't have time to make a special 
// normal attack animation for the paladin class, so I just repurposed the arrow animation.
// I lovingly call this the 'hilt bash' animation because the bitmap used actually ended up
// getting flipped the wrong way.
var autoAttack = function() {
	console.log("hitting")

	setCanvas();
	var stage = new createjs.Stage("overlay");
	var arrows = createBitmapObject('arrow', 1, '/css/images/holy-sword.png')

	$.each(arrows, function(i, arrow){
		arrow.regY = 50
		arrow.regX = 400
		arrow.x = 250;
		arrow.y = 250;
		stage.addChild(arrow)
	})

	$.each(arrows, function(i, arrow){
		createjs.Tween.get(arrow, {loop: false})
	    .to({x: 500, y:250, alpha: 0}, 150, createjs.Ease.circIn)
	    .to({x: 700, y:Math.random() *(300-200) + 200, alpha: 1}, 150, createjs.Ease.linear)
	    .to({alpha: 0}, 1000)

		createjs.Ticker.setFPS(60);
		createjs.Ticker.addEventListener("tick", this.stage);		
	})

}


playerAttack();
playerBrace();
playerSpecial();
playerRun();

};









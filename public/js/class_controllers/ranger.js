var init = function() {

	// Most of this ended up being coped in to the paladin.js file. Annotations for common
	// methods can be found there. 

	// Really, the only difference is in the volley animation which is toward the bottom of this file. 

	baseUrl = location.protocol + '//' + location.host;

	var setCanvas = function() {
		canvasWidth = document.getElementById("overlay").offsetWidth
		canvasHeight = document.getElementById("overlay").offsetHeight
		$("canvas").css("visibility", "visible");
		$("canvas").remove();
		$("body").append("<canvas id='overlay' height='"+canvasHeight+"' width='"+canvasWidth+"' z-index='99999'></canvas>");
	}

	var createBitmapObject = function(name, number, image) {
		var container = Array();
		for (i = 0; i < number; i++) {
				container.push(new createjs.Bitmap(image));
		}
		return container
	}

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
					if (character === "\"lose\""){
			$(".loss").css("visibility", "visible");
			}
			else{
			character = $.parseJSON(character)
			$(".current-special").css("width", character.special + "%");
			$(".current-health").css("width", ((character.current_hp/character.max_hp)*100) +"%");
			$(".char-hp").html("" + Math.floor(character.current_hp));
			$(".char-special").html("" + character.special);
			enemyAttack();
				if (character.special >= 100){
					$(".special").css("visibility", "visible")
				}
				else {
					$(".special").css("visibility", "hidden")
				}			
		}})
	})
}

var enemyAttack = function() {
		$.ajax({
		url: "/battle/defend",
		type: "PUT"
	}).done(function(character){
		if (character === "\"lose\""){
			$(".loss").css("visibility", "visible");
		}
		else {
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
			volley();
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
			volley();
			enemyAttack();
		}
	})
})};

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
				window.location = baseUrl + "/main"
				// I originally had it like this:
				// window.location "https://localhost:9393/main";
				// window.location = "https://"window.location.href+"/main";
			}
			else{
				alert("Escape failed!")
				enemyAttack();
			}
		})

	})
}


// I was extremely proud of this animation. It makes one arrow, which flies offscreen,
// then is followed up by a rain of arrows that randomly set animation endpoints in a range.
// Pretty cool stuff.

var volley = function() {
	console.log("hitting")

	setCanvas();
	var stage = new createjs.Stage("overlay");
	var arrows = createBitmapObject('arrow', 50, '/css/images/small_arrow.png')
	var upArrow = new createjs.Bitmap('/css/images/small_arrow.png')
		upArrow.x = 250
		upArrow.y = 250
		upArrow.regX = 41
		upArrow.regY = 7
		stage.addChild(upArrow)

	$.each(arrows, function(i, arrow){
		arrow.regX = 41
		arrow.regY = 7
		arrow.x = 250;
		arrow.y = 250;
		stage.addChild(arrow)
	})

	$.each(upArrow, function(i, arrow){
		upArrow.rotation = 315
		createjs.Tween.get(upArrow, {loop: false})
			.to({x: 550, y:-500}, 300, createjs.Ease.circIn)
	})

	$.each(arrows, function(i, arrow){
		arrow.rotation = 45
		createjs.Tween.get(arrow, {loop: false})
			.to({alpha: 0}, 0)
	    .to({x: 500, y:-550, alpha: 0}, Math.random() *(500-100) + 100, createjs.Ease.circIn)
	    .to({x: Math.random() *(1200 - 600) + 600, y:440, alpha: 1}, 1000, createjs.Ease.linear)
	    .to({alpha: 0}, 1000)

		createjs.Ticker.setFPS(60);
		createjs.Ticker.addEventListener("tick", this.stage);	
	})

}

var autoAttack = function() {
	console.log("hitting")

	setCanvas();
	var stage = new createjs.Stage("overlay");
	var arrows = createBitmapObject('arrow', 1, '/css/images/small_arrow.png')

	$.each(arrows, function(i, arrow){
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


















var init = function() {

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









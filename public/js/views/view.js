var View = function(){

}

View.prototype.unlockCheck = function(unlock, target){
	$.ajax({
		url: '/char',
		type:"PUT"
	}).done(function(character){
		character = $.parseJSON(character)
		if (character.level >= unlock){
			$(target).css("visibility", "visible")
		}
		else{
			$(target).css("visibility", "hidden")
		}
	})
}

View.prototype.updateUi = function() {
	$.ajax({
		url: "/main/info",
		type: "PUT"
	}).done(function(character){
		character = $.parseJSON(character)
		console.log(character[0].exp)
		console.log(character[1])
		$(".current-special").css("width", character[0].special + "%")
		$(".char-special").html("" + character[0].special);
		$(".current-health").css("width", ((character[0].current_hp/character[0].max_hp)*100) +"%");
		$(".char-hp").html("" + Math.floor(character[0].current_hp));
		$(".current-exp").css("width", ((character[0].exp / character[1])*100) +"%");
		$(".char-exp").html(""+character[0].exp)
			if (character[0].special >= 100){
				$(".special").css("visibility", "visible")
			}
			else {
				$(".special").css("visibility", "hidden")
			}
	})
};


View.prototype.updateProfession = function(npc) {
		$(".profession").css("visibility", "visible")
		$(".profession").html(npc.profession)
		if (npc.profession == "Healer"){
			$(".profession").html(npc.profession + " Cost: 10g")
			$(".profession").on("click", function(data){
				$.ajax({
					url: "/heal",
					type: "PUT"
				}).done(function(character){
					character = $.parseJSON(character)
					$(".current-health").css("width", ((character.current_hp/character.max_hp)*100) +"%");
					$(".char-hp").html("" + Math.floor(character.current_hp));
					$(".text-box-innard").html(npc.outro);
					$(".gold-display").html("Gold: "+character.gold)
				})
			})
		}
}

View.prototype.textDisplay = function(eventObject, triggerType, target, lineNum) {
	$(eventObject).on(triggerType, function(){
		$(target).html(CURRENT_TARGET.dialogue[lineNum]);
		$(".next").html("Next");
		lineNum += 1;
		if (lineNum >= CURRENT_TARGET.dialogue.length){
			lineNum = 0;
			$(".next").html("Talk");
		} 
})};

View.prototype.changeNPC = function(eventObject, triggerType, target, npc){
	$(eventObject).on(triggerType, function(){
		$(target).css("background", "url("+npc.picture+")"+"center center");
		$(target).css("background-size", "cover");
		$(".next").html("Talk");
		$(".text-box-innard").html(npc.intro);
		$(".status-window").html(npc.name)
		console.log(npc)
		view.updateProfession(npc);
		CURRENT_TARGET = npc
})};

View.prototype.changeCity = function(city){
		this.updateUi();
		$(".map-display").css("background", "url("+city.picture+")"+"center center");
		$(".map-display").css("background-size", "cover");
		$("html").css("background", "url("+city.background+")no-repeat");
		$("html").css("background-size", "cover");
		$(".text-box-innard").html(city.description);
		$(".city-name").html(city.name);
};

View.prototype.generateNPCs = function(npcList) {
	$(".map-display").empty();
		$.each(npcList, function(index, npc){
			$(".map-display").append("<button class=npc"+index+">"+npc.name+"</button>");
				if (npc.profession == 'Healer'){
					$(".npc"+index).css("background-color", "#33CC33");
				}
				else{
					$(".npc"+index).css("background-color", "#3366FF");
				}
				$(".npc"+index).css("color", "white");
				$(".npc"+index).css("border-radius", "7px");
				$(".npc"+index).css("position", "absolute");
				$(".npc"+index).css("left", npc.location[0]+"%");
				$(".npc"+index).css("bottom", npc.location[1]+"%");
				$(".npc"+index).css("font-size", "60%");
				$(".npc"+index).css("z-index", "1");
		})
}

View.prototype.generateBattles = function(areaList) {
	$.each(areaList, function(index, area){
		$(".map-display").append("<a href='/battle'><button class=battle"+index+">"+area.name+"</button></a>");
			$(".battle"+index).css("color", "black");
			$(".battle"+index).css("background-color", "#FF6600");
			$(".battle"+index).css("position", "absolute");
			$(".battle"+index).css("font-size", "60%");
			$(".battle"+index).css("z-index", "1");
			$(".battle"+index).css("left", area.location[0]+"%");
			$(".battle"+index).css("bottom", area.location[1]+"%");
	})
}

View.prototype.generateBoss = function(areaList, id) {
	$.each(areaList, function(index, area){
		index = index+100
		$(".map-display").append("<a href='/battle/"+id+"'><button class=battle"+index+">"+area.name+"</button></a>");
			$(".battle"+index).css("color", "gray");
			$(".battle"+index).css("background-color", "#FFFF66");
			$(".battle"+index).css("position", "absolute");
			$(".battle"+index).css("font-size", "60%");
			$(".battle"+index).css("z-index", "1");
			$(".battle"+index).css("left", area.location[0]+"%");
			$(".battle"+index).css("bottom", area.location[1]+"%");
	})
}
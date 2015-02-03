CURRENT_TARGET = "none"
BAR_STATE = 1
var timeCycle = .1
ITEM_TOGGLE = 1

$(document).ready(function(){

view = new View


var ryu = {
	name: "Ryu",
	picture: "/css/images/ryu-sfiv-select.png",
	dialogue: "I am Ryu.#~I am OP as fuck in Street Fighter 4.#~You don't want to mess with me.".split("#~"),
	intro: "Watch yourself.",
	location: [75, 27],
	profession: "Trainer"
}

var sonia = {
	name: "Sonia",
	picture: "/css/images/sonia.png",
	dialogue: "Hi! My name is Sonia!#~What would you like?#~I have lots to sell!".split("#~"),
	intro: "Come see my goods!",
	location: [46, 50],
	profession: 'Shopkeeper'
}

var poofy = {
	name: "Poofy",
	picture: "/css/images/npc-test.png",
	dialogue: "I'm Poofy!#~Do you need healing?#~All better! Keep fighting!".split("#~"),
	intro: "Hey there!",
	location: [22, 70],
	profession: "Healer"
}

var grandCentral = {
	name :"Grand Central",
	picture: "/css/images/main_city.jpg",
	description: "The main center of trade on the mainland. You can find vendors, healing, and combat training here.",
	background: "/css/images/main_bg.jpg"
}

var trainingGround = {
	name: "Training Ground",
	location: [60, 70]
}

var oldHouse = {
	name: "Balthazar Mansion",
	location: [20, 30]
}

view.unlockCheck(2, ".battle100");
view.updateUi();
view.generateNPCs([ryu, sonia, poofy]);
view.changeCity(grandCentral);
view.generateBattles([trainingGround])
view.generateBoss([oldHouse], 9);
view.textDisplay(".trigger-text","click",".text-box-innard", 0);
view.textDisplay(".next","click",".text-box-innard", 0);
view.changeNPC(".npc0","click",".npc-display", ryu);
view.changeNPC(".npc1","click",".npc-display", sonia);
view.changeNPC(".npc2","click",".npc-display", poofy);


});
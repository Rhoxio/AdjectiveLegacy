CURRENT_TARGET = "none"
BAR_STATE = 1
var timeCycle = .1
ITEM_TOGGLE = 1

$(document).ready(function(){

view = new View


var malthus = {
	name: "Malthus",
	picture: "/css/images/coast_graphics/blacksmith.jpg",
	dialogue: "I am Malthus; also known as the best smith in the land.#~Do you need some work done?".split("#~"),
	intro: "Hello there!",
	profession: "Blacksmith",
	location: [25, 27]
}

var oldPirate = {
	name: "Old Pirate",
	picture: "/css/images/coast_graphics/old_man.jpg",
	dialogue: "You don't know my name? That makes two of us!#~I lost my head after a fight with a kraken.#~I still have his eye!".split("#~"),
	intro: "Do you need something?",
	profession: "Bum",
	location: [10, 55]
}

var poofy = {
	name: "Poofy",
	picture: "/css/images/npc-test.png",
	dialogue: "I'm Poofy!#~Do you need healing?".split("#~"),
	intro: "Hey there!",
	outro :"All better! Keep fighting!",
	profession: "Healer",
	location: [22, 70]
}

var lucciniCoast = {
	name :"Luccini Coast",
	picture: "/css/images/coast_graphics/coastal_city.jpg",
	description: "A devious port town with a repuation for violence. Most trade filters in and out of it's ports.",
	background: "/css/images/coast_graphics/coastal_background.jpg"

}

var causeways = {
	name: "Causeways",
	location: [37, 90]
}

var townCenter = {
	name: "Town Center",
	location: [35, 50]
}


view.unlockCheck(6, ".battle100");
view.updateUi();
view.generateNPCs([malthus, oldPirate, poofy]);
view.changeCity(lucciniCoast);
view.generateBattles([causeways])
view.generateBoss([townCenter], 8)
view.textDisplay(".trigger-text","click",".text-box-innard", 0);
view.textDisplay(".next","click",".text-box-innard", 0);
view.changeNPC(".npc0","click",".npc-display", malthus);
view.changeNPC(".npc1","click",".npc-display", oldPirate);
view.changeNPC(".npc2","click",".npc-display", poofy);


});
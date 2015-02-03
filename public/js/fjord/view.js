CURRENT_TARGET = "none"
BAR_STATE = 1
var timeCycle = .1
ITEM_TOGGLE = 1

$(document).ready(function(){

view = new View


var ghille = {
	name: "Ghille",
	picture: "/css/images/mountain_graphics/ghille.jpg",
	dialogue: "How did you find me?#~If you know what is best for you, stay away from the peaks#~A great monster lives there.#~Even the mightiest of warriors have fallen to his wrath.".split("#~"),
	intro: "...",
	profession: "Tracker",
	location: [67, 65]
}

var resarcia = {
	name: "Resarcia",
	picture: "/css/images/mountain_graphics/mystic.jpg",
	dialogue: "You are brave to venture this far in to the wilds.#~Do you need healing? I can do it for a small price.".split("#~"),
	intro: "A visitor? How unusual...",
	profession: "Healer",
	location: [45, 25]
}

var bjarke = {
	name: "Bjarke",
	picture: "/css/images/mountain_graphics/viking.jpg",
	dialogue: "How are you not frozen to death in those clothes?#~Your getup is almost as inefficient as mine.#~Sure makes me look cool, though.".split("#~"),
	intro: "Hail, stranger. Do you wish to hear some viking wisdom today?",
	profession: "Viking Philosopher",
	location: [25, 68]
}

// --Main Area--

var roknarFjord = {
	name: "Roknar Fjord",
	picture: "/css/images/mountain_graphics/mountain_overhead.jpg",
	description: "A rugged area that holds vast quantities of unexplored land. Known for it's natural beauty.",
	background: "/css/images/mountain_graphics/mountain_bg.jpg"
}

// --Battle Areas--

var snowField = {
	name: "Lowland Burms",
	location: [30, 58]
}

var yetiCave = {
	name: "Raksasha's Domain",
	location: [72,38]
}

view.unlockCheck(10, ".battle100");
view.updateUi();
view.generateNPCs([ghille,resarcia,bjarke]);
view.changeCity(roknarFjord);
view.generateBattles([snowField]);
view.generateBoss([yetiCave], 12);
view.textDisplay(".trigger-text","click",".text-box-innard", 0);
view.textDisplay(".next","click",".text-box-innard", 0);
view.changeNPC(".npc2","click",".npc-display", bjarke);
view.changeNPC(".npc1","click",".npc-display", resarcia);
view.changeNPC(".npc0","click",".npc-display", ghille);


});
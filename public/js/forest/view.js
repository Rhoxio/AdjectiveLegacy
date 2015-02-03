CURRENT_TARGET = "none"
BAR_STATE = 1
var timeCycle = .1
ITEM_TOGGLE = 1

$(document).ready(function(){

view = new View


var sapius = {
	name: "Sapius",
	picture: "/css/images/wizard.jpg",
	dialogue: "Do you know about the wonders of magic?#~If you don't, I can teach you some basic spells.#~It costs a small amount of coin, but is well worth it.".split("#~"),
	intro: "Magic is the greatest source of power. Don't you agree?",
	profession: "Magus",
	location: [75, 30]
}

var sanatora = {
	name: "Sanatora",
	picture: "/css/images/cleric.png",
	dialogue: "If you wish to donate to the Church of Atamosk, then I will heal you.#~Your contribution will go toward the distribution of swift justice across the land.#~Why are you looking at me like that?".split("#~"),
	intro: "We will cleanse this land in holy fire.",
	profession: "Healer",
	location: [45, 50]
}

var auctus = {
	name: "Auctus",
	picture: "/css/images/ent.jpg",
	dialogue: "Do you love the forest? Have you come to cleanse the evil that is the Hadnar Clan?#~If you do so, I will give you an item of great power.".split("#~"),
	intro: "Hello, fleshling.",
	profession: "Tree Shepard",
	location: [25, 25]
}

var eluna = {
	name: "Eluna",
	picture: "/css/images/elf_queen.jpg",
	dialogue: "Hello, I am known as Eluna.#~The men in the north are dangerous.#~I avoid the area, lest I be taken and improsoned for my beauty.".split("#~"),
	intro: "Fear the north. It harbors evil men.",
	profession: "Muse",
	location: [25, 68]
}

// --Main Area--

var oldForest = {
	name :"Old Forest",
	picture: "/css/images/forest_map.jpg",
	description: "A cursed forest where dark things lurk. It is ruled by a tyrant king in the north who values strength above all else.",
	background: "/css/images/forest.jpg"
}

// --Battle Areas--

var forestClearing = {
	name: "Forest Clearing",
	location: [47, 75]
}

var kingsLanding = {
	name: "King's Domain",
	location: [45, 90]
}

view.unlockCheck(5, ".battle100");
view.updateUi();
view.generateNPCs([sapius, sanatora, auctus, eluna]);
view.changeCity(oldForest);
view.generateBattles([forestClearing]);
view.generateBoss([kingsLanding], 13);
view.textDisplay(".trigger-text","click",".text-box-innard", 0);
view.textDisplay(".next","click",".text-box-innard", 0);
view.changeNPC(".npc3","click",".npc-display", eluna);
view.changeNPC(".npc2","click",".npc-display", sapius);
view.changeNPC(".npc1","click",".npc-display", sanatora);
view.changeNPC(".npc0","click",".npc-display", auctus);


});
CURRENT_TARGET = "none"
BAR_STATE = 1
var timeCycle = .1
ITEM_TOGGLE = 1

$(document).ready(function(){

view = new View

$("html").css("background-color", "#47A3FF")

$("body").append("<button class='back'>Go Back to Grand Central</button>")

$(".next").on("click", function(event){
	$.ajax({
		url: '/reset_position',
		type: 'PUT'
	}).done(function(data){
		location.reload();
	})
})


var development = {
	name :"In Development",
	picture: "",
	description: "Click the 'Info' Button to go back to Grand Central",
	background: ""
}


view.updateUi();
view.changeCity(development);


});
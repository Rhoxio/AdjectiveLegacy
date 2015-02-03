var Controller = function(){

}

Controller.prototype.initEvents = function(){

	$(".day-cycle").on("click", function() {
		$(".bg-overlay").css("opacity", timeCycle);
		timeCycle += .1;
		if (timeCycle > .9) {
			timeCycle = .9
		};
	});

	$(".night-cycle").on("click", function() {
		$(".bg-overlay").css("opacity", timeCycle);
			timeCycle -= .1;
			if (timeCycle < .1) {
				timeCycle = .1
		};
	});

	$(".hide-bar").on("click", function(){
		if (BAR_STATE == 0){
			$(".menu-box").css("visibility", "hidden");
			BAR_STATE = 1
		}
		else if(BAR_STATE ==1){
			$(".menu-box").css("visibility", "visible");
			BAR_STATE = 0
		}
	});

	$(".item-toggle").on("click", function(){
		if (ITEM_TOGGLE == 0){
			$(".item-window").css("visibility", "hidden");
			ITEM_TOGGLE = 1
		}
		else if(ITEM_TOGGLE ==1){
			$(".item-window").css("visibility", "visible");
			ITEM_TOGGLE = 0
		}
	})
}

$(document).ready(function(){
	controller = new Controller
	view = new View
	view.updateUi();
	controller.initEvents();
})
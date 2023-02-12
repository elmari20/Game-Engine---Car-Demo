extends Control


var menu
var speedometer



func _ready():
	menu = get_node("Buttons")
	speedometer = get_node("Speedometer")
	menu.hide()
	set_process(true) 
	

func _input(event):
	if event.is_action_pressed("Pause"):
		if menu.visible:
			menu.hide()
			speedometer.show()
			
		else:
			menu.show()
			speedometer.hide()

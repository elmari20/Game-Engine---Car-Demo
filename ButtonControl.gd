extends Control


var menu
var speedometer


func _ready():
	set_process_input(true)
	menu = get_node("Buttons") 
	speedometer = get_node("Speedometer")
	

func _input(event):
	if event.is_action_pressed("Pause"):
		if menu.visible:
			menu.hide()
			speedometer.show()
		else:
			menu.show()
			speedometer.hide()
		print("their Escape was pressed")

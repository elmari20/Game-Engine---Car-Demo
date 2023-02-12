extends Control


var menu
var speedometer
var parent
var car
var original_mode
var linear_velocity = Vector3()
var angular_velocity = Vector3()


func _ready():
	menu = get_node("Buttons")
	speedometer = get_node("Speedometer")
	parent = get_parent()
	car = get_node("../Car")
	original_mode = car.mode
	menu.hide()
	set_process(true) 
	

func _input(event):
	if event.is_action_pressed("Pause"):
		if menu.visible:
			menu.hide()
			speedometer.show()
			car.mode = original_mode
			car.set_linear_velocity(linear_velocity)
			car.set_angular_velocity(angular_velocity)
			
			car.set_process(true)
		else:
			menu.show()
			speedometer.hide()
			linear_velocity = car.get_linear_velocity()
			angular_velocity = car.get_angular_velocity()
			original_mode = car.mode
			car.mode = PhysicsServer.BODY_MODE_KINEMATIC
			car.set_process(false)

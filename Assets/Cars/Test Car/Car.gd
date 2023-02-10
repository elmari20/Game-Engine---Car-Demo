extends VehicleBody


export var max_rpm = 800
export (float, 0,10,0.1 )var MAX_BRAKE_FORCE = 5.0
var max_torque = 350

export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0


func _physics_process(delta):
	var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)
	steering = lerp(steering, Input.get_axis("Right", "Left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("Down","Up")
	if Input.is_action_pressed("ui_down"):
		brake_val = 1.0
	brake = brake_val * MAX_BRAKE_FORCE
	var rpm = $left_rear.get_rpm()
	$left_rear.engine_force = acceleration * max_torque * (1 - rpm / max_rpm) * (100 *delta)
	rpm = $right_front.get_rpm()
	$right_front.engine_force = acceleration * max_torque * (1 - rpm / max_rpm) * (100 *delta)
	
	$left_front/left_front.rotation_degrees.x += rpm/(60*delta) 
	$right_front/right_front.rotation_degrees.x += rpm/(60*delta)
	$left_rear/left_rear.rotation_degrees.x += rpm/(60*delta)
	$rear_right/rear_right.rotation_degrees.x += rpm/(60*delta)
	
	

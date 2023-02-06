extends VehicleBody


var max_rpm = 500
var max_torque = 400

func _physics_process(delta):
	steering = lerp(steering, Input.get_axis("Right", "Left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("Down","Up")
	var rpm = $left_rear.get_rpm()
	$left_rear.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	rpm = $rear_right.get_rpm()
	$rear_right.engine_force = acceleration * max_torque * (1 - rpm / max_rpm)
	

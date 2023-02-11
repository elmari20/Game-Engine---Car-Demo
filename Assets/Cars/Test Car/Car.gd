extends VehicleBody


export var max_rpm = 800
var max_torque = 500

export (float, 0,10,0.1 )var MAX_BRAKE_FORCE = 5.0
export var joy_brake = JOY_ANALOG_L2
export var brake_mult = 1.0

var play_accelerate = false;
var play_decelerate = false;
var play_engine = false;


func _physics_process(delta):
	play_sound()
	var brake_val = brake_mult * Input.get_joy_axis(0, joy_brake)
	steering = lerp(steering, Input.get_axis("Right", "Left") * 0.4, 5 * delta)
	var acceleration = Input.get_axis("Down","Up")
	if Input.is_action_pressed("Stop"):
		brake_val = 1.0
	

	
	brake = brake_val * MAX_BRAKE_FORCE
	var rpm = $left_rear.get_rpm()
	$left_rear.engine_force = acceleration * max_torque * (1 - abs(rpm) / max_rpm) * (100 *delta)

	rpm = $rear_right.get_rpm()
	$rear_right.engine_force = acceleration * max_torque * (1 - abs(rpm) / max_rpm) * (100 *delta)
	
		
	
	
func play_sound():
	if Input.is_action_pressed("Up") and !play_accelerate:
		$Accelerate.play();
		play_accelerate = true;
		play_decelerate = false;
	if !Input.is_action_pressed("Up") and !play_decelerate:
		$Accelerate.stop();
		play_accelerate = false;
		$Decelerate.play();
		play_decelerate = true;
		$TopSpeed.stop();
		play_engine = false;
	if !play_engine and play_accelerate and !$Accelerate.is_playing():
		$TopSpeed.play();
		play_engine = true;

extends VehicleBody


const STEER_SPEED = 1.5
const STEER_LIMIT = 0.6
var steer_target = 0
export var engine_force_value = 40

var play_accelerate = false;
var play_decelerate = false;
var play_engine = false;



func _physics_process(delta):
	play_sound()
	var fwd_mps = transform.basis.xform_inv(linear_velocity).x
	steer_target = Input.get_action_strength("Left") -  Input.get_action_strength("Right")
	steer_target *= STEER_LIMIT

	if Input.is_action_pressed("Up"):
		var speed = linear_velocity.length()
		print($rear_right.engine_force)
		if speed < 5 and speed != 0:
			$left_rear.engine_force = clamp(engine_force_value * 5 / speed, 0, 100)
			$rear_right.engine_force = clamp(engine_force_value * 5 / speed, 0, 100)
		else:
			$left_rear.engine_force = engine_force_value
			$rear_right.engine_force = engine_force_value
	else:
		engine_force = 0
	if Input.is_action_pressed("Down"):
		if fwd_mps >= -1:
			var speed = linear_velocity.length()
			if speed < 5 and speed != 0:
				$left_rear.engine_force = -clamp(engine_force_value * 5 / speed, 0, 100)
				$rear_right.engine_force = -clamp(engine_force_value * 5 / speed, 0, 100)
			else:
				$left_rear.engine_force = -engine_force_value
				$rear_right.engine_force = -engine_force_value
		else:
			$left_rear.brake = 1
			$rear_right.brake = 1
	else:
		brake = 0.0

	steering = move_toward(steering, steer_target, STEER_SPEED * delta)
		
	
	
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

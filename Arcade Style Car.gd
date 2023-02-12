extends Spatial

onready var ball = $Ball
onready var car_mesh = $DriftCar
onready var ground_ray = $DriftCar/RayCast

onready var right_wheel = $DriftCar/Front_Right_Wheel
onready var left_wheel = $DriftCar/Front_Left_Wheel
onready var body_mesh = $DriftCar/Body

var sphere_offset = Vector3(0, -1.0, 0)
var acceleration = 50
var steering = 21.0
var turn_speed = 5
var turn_stop_limit = 0.75
var body_tilt = 35

var speed_input = 0
var rotate_input = 0

func _ready():
	ground_ray.add_exception(ball)
	
	
func _physics_process(delta):
	car_mesh.transform.origin.x = ball.transform.origin.x + sphere_offset.x
	car_mesh.transform.origin.z = ball.transform.origin.z + sphere_offset.z
	car_mesh.transform.origin.y = lerp(car_mesh.transform.origin.y, ball.transform.origin.y + sphere_offset.y, 1 * delta)
	ball.add_central_force(-car_mesh.global_transform.basis.z * speed_input)
	
func _process(delta):
	if not ground_ray.is_colliding():
		speed_input = 0
	
	# rotate wheels for effect
	right_wheel.rotation.y = rotate_input
	left_wheel.rotation.y = rotate_input
	
	var d = ball.linear_velocity.normalized().dot(-car_mesh.transform.basis.z)
	print(d)
	if d > 0.5 or d < -0.5:
		$DriftCar/Smoke.emitting = true
		$DriftCar/Smoke2.emitting = true
	else:
		$DriftCar/Smoke.emitting = false
		$DriftCar/Smoke2.emitting = false
	
	speed_input = 0
	speed_input += Input.get_action_strength("Up")
	speed_input -= Input.get_action_strength("Down")
	speed_input *= acceleration
	
	rotate_input = 0
	rotate_input += Input.get_action_strength("Left")
	rotate_input -= Input.get_action_strength("Right")
	rotate_input *= deg2rad(steering)
	
	if ball.linear_velocity.length() > turn_stop_limit:
		var new_basis = car_mesh.global_transform.basis.rotated(car_mesh.global_transform.basis.y, rotate_input)
		car_mesh.global_transform.basis = car_mesh.global_transform.basis.slerp(new_basis, turn_speed * delta)
		car_mesh.global_transform = car_mesh.global_transform.orthonormalized()


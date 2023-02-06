extends Spatial

var direction = Vector3.FORWARD
export (float,1,10,0.1) var smooth_turn = 2.5

func _physics_process(delta):
	var current_velocity = get_parent().get_linear_velocity()
	current_velocity.y = 0
	if current_velocity.length_squared() > 1:
		direction = lerp(direction, -current_velocity.normalized(),smooth_turn * delta) 
	global_transform.basis = get_rotation_from_direction(direction)
	
func get_rotation_from_direction(look_dir: Vector3) -> Basis:
	look_dir = look_dir.normalized()
	var x = look_dir.cross(Vector3.UP)
	return Basis(x, Vector3.UP, -look_dir)

class_name Enemy extends Character


@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Player")
var hp = 1000
func chase() -> void:
	look_at(player.global_position, Vector3.UP, true)
	rotation.x = 0  
	rotation.z = 0 
	if is_instance_valid(player):
		move_direction = global_position.direction_to(player.global_position)
	else:
		move_direction = Vector3.ZERO

class_name Enemy extends Character


@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Player")
@onready var aim_raycast: RayCast3D = $RayCast3D

func chase() -> void:
	var distance_to_player = (player.position - global_position).length()
	aim_raycast.target_position = player.position - global_position
	
	if is_instance_valid(player) and aim_raycast.get_collider() == player and distance_to_player < 20:
		move_direction = global_position.direction_to(player.global_position)
	else:
		move_direction = Vector3.ZERO
		
func _on_hp_changed(new_hp : Variant) -> void:
	%ProgressBar.value = (new_hp / max_health_points) * 100
	

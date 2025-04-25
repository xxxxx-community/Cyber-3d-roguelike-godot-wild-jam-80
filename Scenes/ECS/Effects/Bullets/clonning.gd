extends EffectComponent


func _collide(body : Node3D) -> void:
	if not body.has_method("take_damage"):
		return 
		
	apply_effect(body)
	queue_free()

func apply_effect(body : Node3D) -> void:
	var new_body : Node3D = body.duplicate()
	get_tree().current_scene.get_node("SpawnRooms").current_room.add_child(new_body)
	new_body.global_position = body.global_position + Vector3(1, 0, 1)

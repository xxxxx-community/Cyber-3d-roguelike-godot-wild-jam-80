extends Projectile


var applied : bool = false

func _collide(body : Node3D) -> void:
	if not body.has_method("take_damage") or body == attacker:
		return 
	
	if not applied:
		applied = true
		apply_effect(body)
	animation_player.play("end_projectile")

func apply_effect(body : Node3D) -> void:
	var new_body : Node3D = body.duplicate()
	get_tree().current_scene.add_child(new_body)
	new_body.global_position = body.global_position

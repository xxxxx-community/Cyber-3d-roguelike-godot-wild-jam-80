extends Projectile


func _collide(body : Node3D) -> void:
	if not body.has_method("take_damage") or body == attacker:
		return 
		
	apply_effect(body)
	#animation_player.play("end_projectile")

func apply_effect(body : Node3D) -> void:
	body.scale *= randf_range(0.1, 2)

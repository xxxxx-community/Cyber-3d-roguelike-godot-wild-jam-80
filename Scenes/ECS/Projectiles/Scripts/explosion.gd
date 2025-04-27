extends Projectile


func _collide(body : Node3D) -> void:
	animation_player.play("end_projectile")
	collision_shape_3d.shape.radius = 6
	if not body.has_method("take_damage") or body == attacker:
		return 
		
	body.take_damage(damage, knockback_direction)
	

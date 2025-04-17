extends Component


func active_effect(body) -> void:
	if parent_projectile is Projectile:
		body.take_damage(damage, parent_projectile.knockback_direction, parent_projectile.knockback_force)
		var new_effect : Node3D = duplicate()
		body.add_child(new_effect)
		new_effect.damage = -1
		body.accel /= 3
	else:
		body.take_damage(damage)
		point_life -= 1
		if point_life <= 0:
			body.accel = body.acceleration
			queue_free()

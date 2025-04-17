extends Component


func active_effect(body) -> void:
	body.accel /= 5
	body.take_damage(damage, parent_projectile.knockback_direction, parent_projectile.knockback_force)

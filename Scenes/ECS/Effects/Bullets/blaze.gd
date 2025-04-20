extends EffectComponent


var duration_damage : int = 6

func _collide(body : Node3D) -> void:
	if not body.has_method("take_damage"):
		return 
		
	body.take_damage(
		damage, knockback_direction, knockback_force
		)
	# Если это эффект снаряда, то накладываем его на сущность
	if carrier_effect is Projectile:
		apply_effect(body)
	elif carrier_effect is Character:
		duration_damage -= 1
		if duration_damage <= 0:
			queue_free()

func apply_effect(body : Node3D) -> void:
	var new_effect : Node3D = self.duplicate()
	body.get_node("Components").add_child(new_effect)
	new_effect.damage = damage / 4

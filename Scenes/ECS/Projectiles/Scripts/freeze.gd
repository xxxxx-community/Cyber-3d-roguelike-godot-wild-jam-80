extends Projectile


# сколько раз нанесёт урон (сначала происходит просто урон от снаряда,
# а потом дополнительно duration_damage раз)
var duration_damage : int = 8

func _collide(body : Node3D) -> void:
	if not body.has_method("take_damage") or body == attacker:
		return 
		
	body.take_damage(damage, knockback_direction)
	
	if get_parent() is Character:
		duration_damage -= 1
		if duration_damage <= 0:
			get_parent().acceleration *= 4
			animation_player.play("end_projectile")
	else:
		projectile_speed = 0
		# Если это эффект снаряда, то накладываем его на сущность
		animation_player.play("end_projectile")
		apply_effect(body)

func apply_effect(body : Node3D) -> void:
	var new_effect : Node3D = self.duplicate()
	body.add_child(new_effect)
	new_effect.position = Vector3.ZERO
	new_effect.damage /= 2
	body.acceleration /= 4

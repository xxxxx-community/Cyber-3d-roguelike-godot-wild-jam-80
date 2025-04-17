extends Hitbox


func _collide(body) -> void:
	if is_instance_valid(body) and body.has_method("take_damage"):
		owner.active_effect(body)

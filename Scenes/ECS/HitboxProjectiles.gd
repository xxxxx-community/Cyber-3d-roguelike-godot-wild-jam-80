extends Hitbox


func _collide(body) -> void:
	if body.has_method("take_damage"):
		owner.active_effect(body)

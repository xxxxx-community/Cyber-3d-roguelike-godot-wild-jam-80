extends EffectComponent


func _collide(body : Node3D) -> void:
	if not body.has_method("take_damage"):
		return 
		
	apply_effect(body)
	queue_free()

func apply_effect(body : Node3D) -> void:
	body.scale *= randf_range(0.1, 2)

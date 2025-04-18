extends EffectComponent


@export var curve_gravity : Curve

func _collide(body) -> void:
	if not body.has_method("take_damage"):
		return 
	var length : float = (global_position - body.global_position).length()
	
	if length < 4:
		body.take_damage(
			damage, knockback_direction, knockback_force
			)
	
func _physics_process(_delta: float) -> void:
	for entity in get_tree().get_nodes_in_group("ENTITY_GROUP"):
		var length : float = (global_position - entity.global_position).length()
		if length < 20:
			entity.velocity += (global_position - entity.global_position).normalized() * curve_gravity.sample(length)
				

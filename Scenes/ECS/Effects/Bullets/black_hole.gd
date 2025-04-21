extends EffectComponent


@export var curve_gravity : Curve

func _ready() -> void:
	super()
	carrier_effect.deading = false
	$GPUParticles3D.emitting = false
	$CollisionShape3D.disabled = true
	
func _collide(body) -> void:
	if not body.has_method("take_damage"):
		return 
	var length : float = (global_position - body.global_position).length()
	
	if length < 4:
		body.take_damage(
			damage, knockback_direction, knockback_force
			)
	
func _physics_process(_delta: float) -> void:
	if not $Timer.is_stopped():
		for entity in get_tree().get_nodes_in_group("ENTITY_GROUP"):
			var length : float = (global_position - entity.global_position).length()
			if length < 60:
				entity.velocity += (global_position - entity.global_position).normalized() * curve_gravity.sample(length)
				

func stop() -> void:
	super()
	$Timer.start()
	$GPUParticles3D.emitting = true
	$CollisionShape3D.set_deferred("disabled", false)
	
func _on_timer_timeout() -> void:
	carrier_effect.get_node("AnimationPlayer").play(&"dead")

extends EffectComponent


func _ready() -> void:
	super()
	$GPUParticles3D.emitting = false
	$CollisionShape3D.disabled = true
	
func _collide(body : Node3D) -> void:
	if not body.has_method("take_damage") or not can_collide:
		return 
		
	body.take_damage(
		damage, knockback_direction, knockback_force
		)
	can_collide = false

func stop() -> void:
	super()
	$GPUParticles3D.emitting = true
	$CollisionShape3D.set_deferred("disabled", false)

extends EffectComponent


@export var curve_gravity : Curve

func _ready() -> void:
	super()
	carrier_effect.deading = false

func _collide(body) -> void:
	print(body)
	
func _physics_process(_delta: float) -> void:
	for entity in get_tree().get_nodes_in_group("ENTITY_GROUP"):
		var length : float = (global_position - entity.global_position).length()
		if length < 20:
			entity.velocity += (global_position - entity.global_position).normalized() * curve_gravity.sample(length)
				
func stop() -> void:
	$GPUParticles3D.emitting = true
	await get_tree().create_timer(10).timeout
	$GPUParticles3D.emitting = false
	await get_tree().create_timer(2).timeout
	carrier_effect.queue_free()

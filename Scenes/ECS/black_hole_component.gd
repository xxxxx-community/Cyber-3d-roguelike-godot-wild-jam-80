extends Component


@export var curve_gravity : Curve

func _ready() -> void:
	parent_projectile.deading = false

func _physics_process(_delta: float) -> void:
	for entity in get_tree().get_nodes_in_group("ENTITY_GROUP"):
		var length : float = (global_position - entity.global_position).length()
		if length < 20:
			entity.accel /= 5
			entity.velocity += (global_position - entity.global_position).normalized() * curve_gravity.sample(length)
			if length < 3 and entity.name != "Player":
				entity.health_points -= 0.1

func stop() -> void:
	$GPUParticles3D.emitting = true
	await get_tree().create_timer(10).timeout
	$GPUParticles3D.emitting = false
	await get_tree().create_timer(2).timeout
	parent_projectile.queue_free()

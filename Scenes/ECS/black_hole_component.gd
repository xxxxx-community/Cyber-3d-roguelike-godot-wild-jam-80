extends Component


func _ready() -> void:
	parent_projectile.deading = false
	$GPUParticles3D.emitting = false

func stop() -> void:
	$GPUParticles3D.emitting = true
	await get_tree().create_timer(10).timeout
	$GPUParticles3D.emitting = false
	await get_tree().create_timer(2).timeout
	parent_projectile.queue_free()

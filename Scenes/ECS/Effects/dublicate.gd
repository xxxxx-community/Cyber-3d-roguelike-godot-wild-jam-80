extends Node3D


@onready var carrier_effect : Node3D = get_parent().get_parent()


func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	if not get_parent().has_node("BlackHole"):
		_spawn_projectile()

func _spawn_projectile() -> void:
	var new_bullet : Area3D = carrier_effect.duplicate()
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.launch(
		self, global_position, carrier_effect.rotation, carrier_effect.projectile_speed, 0.3
		) 
	
func stop() -> void:
	if has_node("GPUParticles3D"):
		$GPUParticles3D.emitting = false
		
	if has_node("Timer"):
		$Timer.one_shot = true
	

extends Node3D


@onready var carrier_effect : Node3D = get_parent().get_parent()
var stopping : bool = false

func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	if not stopping:
		_spawn_projectile()

func _spawn_projectile() -> void:
	var new_bullet : Area3D = carrier_effect.duplicate()
	new_bullet.launch(
		self, global_position, carrier_effect.rotation, carrier_effect.projectile_speed, 0.3
		) 
	get_tree().current_scene.add_child(new_bullet)
	
func stop() -> void:
	stopping = true
	

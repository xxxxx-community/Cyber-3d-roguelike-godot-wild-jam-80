class_name Component extends Node3D


@onready var parent_projectile : Area3D = get_parent().get_parent()

func stop() -> void:
	if has_node("GPUParticles3D"):
		$GPUParticles3D.emitting = false
		
	if has_node("Timer"):
		$Timer.one_shot = true

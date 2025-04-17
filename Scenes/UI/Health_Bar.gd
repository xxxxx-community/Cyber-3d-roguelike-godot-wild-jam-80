extends Node3D
func _process(delta: float) -> void:
	$Sprite3D/SubViewport/ProgressBar.value = $"../../..".hp

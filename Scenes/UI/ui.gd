extends CanvasLayer


func _on_player_hp_changed(new_hp: Variant) -> void:
	$ProgressBar.value = (new_hp / $"..".max_health_points) * 100
	

extends CanvasLayer


func _on_player_hp_changed(new_hp: Variant) -> void:
	$ProgressBar.value = (new_hp / $"../Player".max_health_ponts) * 100
	

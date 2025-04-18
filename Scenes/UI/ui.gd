extends CanvasLayer


@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Player")

func _on_player_hp_changed(new_hp: Variant) -> void:
	$ProgressBar.value = (new_hp / $"..".max_health_points) * 100

func _unhandled_input(event) -> void:
	if event.is_action_pressed(&"ui_cancel"):
		if %Options_Menu.visible:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			player.can_move = true
			
			$ProgressBar.show()
			%Options_Menu.hide()
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			player.can_move = false
			
			$ProgressBar.hide()
			%Options_Menu.show()
			

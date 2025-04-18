extends Control

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_options_button_pressed() -> void:
	%CamPlayer.play("cam_options")
	


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_cam_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://Scenes/GUI/Menu/opt_menu_room.tscn")

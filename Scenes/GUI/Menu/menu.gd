extends Control

var scene = preload("res://Scenes/GUI/Menu/opt_menu_room.tscn")

func _on_play_button_pressed() -> void:
	$button1.play()
	if SettingsData.custscene:
		SettingsData.custscene = false
		$"../AnimationPlayer".play(&"story")
	else:
		start_game() 
	
func start_game() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")


func _on_options_button_pressed() -> void:
	$button1.play()
	%CamPlayer.play("cam_options")
	

func _on_quit_button_pressed() -> void:
	$button1.play()
	get_tree().quit()


func _on_cam_player_animation_finished(anim_name: StringName) -> void:
	get_tree().change_scene_to_packed(scene)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"ui_accept"):
		$"../AnimationPlayer".speed_scale *= 2

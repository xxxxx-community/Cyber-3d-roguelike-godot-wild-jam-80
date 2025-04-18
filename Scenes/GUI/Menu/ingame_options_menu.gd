extends Control

func _ready() -> void:
	# Инициализируем UI текущими значениями
	%Volume.value = SettingsData.volume
	%Mute.button_pressed = SettingsData.mute
	%FullscreenButton.button_pressed = SettingsData.fullscreen

func _on_button_pressed() -> void:
	$button1.play()
	get_tree().quit()

func _on_volume_value_changed(value: float) -> void:
	$button2.play()
	SettingsData.volume = value

func _on_mute_toggled(toggled_on: bool) -> void:
	$button2.play()
	SettingsData.mute = toggled_on

func _on_fullscreen_button_toggled(button_pressed: bool) -> void:
	$button3.play()
	SettingsData.fullscreen = button_pressed

func _on_volume_drag_ended(value_changed: bool) -> void:
	if value_changed:
		SettingsData.save_settings()

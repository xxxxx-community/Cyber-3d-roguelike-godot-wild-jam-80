extends Node

const CONFIG_PATH = "user://settings.ini"
var custscene : bool = true

var volume: float = 0.0:
	set(value):
		volume = value
		save_settings()
var mute: bool = false:
	set(value):
		mute = value
		save_settings()
var fullscreen: bool = false:
	set(value):
		fullscreen = value
		save_settings()

func _ready() -> void:
	load_settings()

func load_settings() -> void:
	var config = ConfigFile.new()
	var err = config.load(CONFIG_PATH)

	if err == OK:
		self.volume = config.get_value("audio", "volume", 0.0)
		self.mute = config.get_value("audio", "mute", false)
		self.fullscreen = config.get_value("video", "fullscreen", false)
	else:
		save_settings() # Сохраняем дефолтные значения

func save_settings() -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "volume", volume)
	config.set_value("audio", "mute", mute)
	config.set_value("video", "fullscreen", fullscreen)
	config.save(CONFIG_PATH)
	apply_settings()

func apply_settings() -> void:
	AudioServer.set_bus_volume_db(0, volume)
	AudioServer.set_bus_mute(0, mute)
	update_fullscreen()

func update_fullscreen() -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

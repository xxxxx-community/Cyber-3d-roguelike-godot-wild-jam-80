extends Node3D


@onready var grid_map : GridMap = $GridMap
@onready var camera_3d: Camera3D = $Camera3D

func _ready() -> void:
	MenuMusic.play_music_menu()
	camera_3d.set_current(1)

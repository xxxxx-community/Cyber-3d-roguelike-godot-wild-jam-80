extends Node3D


@onready var grid_map : GridMap = $GridMap
@onready var camera_3d_2: Camera3D = $Camera3D2

func _ready() -> void:
	camera_3d_2.set_current(1)

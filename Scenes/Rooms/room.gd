extends Node3D


@onready var grid_map : GridMap = $GridMap
@onready var door : StaticBody3D = $Door


func _ready() -> void:
	var dir : Vector3 = (global_position - door.global_position).normalized().round()
	
	

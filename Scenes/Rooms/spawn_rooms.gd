extends Node3D


# комнаты спавна
const SPAWN_ROOMS        : Array[PackedScene] = [
	preload("res://Scenes/Rooms/SpawnRooms/spawn_room_1.tscn")
	]
	
# обычные комнаты
const INTERMEDIATE_ROOMS : Array[PackedScene] = [
	preload("res://Scenes/Rooms/IntermediateRooms/intermediate_room_Generators.tscn"),
	#preload("res://Scenes/Rooms/IntermediateRooms/intermediate_room_Boss_Room.tscn")
	]
	
# обычные комнаты
const END_ROOMS : Array[PackedScene] = [
	]
	
# Количество комнат
var number_levels : int = 10

@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Player")
var i = 0
var previous_room : Node3D

func _ready():
	_spawn_rooms()

func _spawn_rooms():
	
	#for i in number_levels:
	var room : Node3D
	
	if i == 0:
		room = SPAWN_ROOMS.pick_random().instantiate()
		player.position = room.get_node("PlayerSpawnPoint").position
		
	else:
		# обычная комната
		room = INTERMEDIATE_ROOMS.pick_random().instantiate() 
		
		@warning_ignore("unassigned_variable")
		var grid_map_prev_room : GridMap = previous_room.get_node("GridMap") 
		@warning_ignore("unassigned_variable")
		var door_prev_room : StaticBody3D = previous_room.get_node("Door")
		var exit_pos  : Vector3i = grid_map_prev_room.local_to_map(door_prev_room.global_position) - Vector3i.UP
		
		var grid_map_cur_room : GridMap = room.get_node("GridMap") 
		var connect_cur_room : Marker3D = room.get_node("ConnectingPassage")
		var connect_passage_pos : Vector3i = grid_map_cur_room.local_to_map(connect_cur_room.position) - Vector3i.UP
		
		room.position = exit_pos - connect_passage_pos
		
	add_child(room)
	previous_room = room

func _process(_delta: float) -> void:
	if previous_room.get_node("Door").open:
		i += 1
		_spawn_rooms()

extends Node3D


# комнаты спавна
const SPAWN_ROOMS : Array[PackedScene] = [
	preload("res://Scenes/Rooms/SpawnRooms/room_test.tscn")
	]
	
@onready var player : CharacterBody3D = get_tree().current_scene.get_node("Player")

var index_room : int = 0
var current_room : Node3D
var previous_room : Node3D

func _ready():
	_spawn_rooms()
	
func _spawn_rooms():
	var room : Node3D
	
	if index_room == 0:
		room = SPAWN_ROOMS.pick_random().instantiate()
		player.position = room.get_node("PlayerSpawnPoint").position
		
	add_child(room)
	previous_room = current_room
	current_room = room

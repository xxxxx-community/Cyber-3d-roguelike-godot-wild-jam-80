extends Node3D


const ENEMIES : Array[PackedScene] = [
	preload("uid://crl5qy75a44lb"),
	preload("uid://brbi5wnpy31dc")
	]

func _ready() -> void:
	if has_node("Spawn Points"):
		for point in get_node("Spawn Points").get_children():
			var rand : int = randi_range(0, 1)
			
			var new_enemy : Enemy = ENEMIES[rand].instantiate()
			add_child(new_enemy)
			new_enemy.global_position = point.global_position
			
			# дроны
			if rand == 0:
				new_enemy.global_position.y += randf_range(3, 5)

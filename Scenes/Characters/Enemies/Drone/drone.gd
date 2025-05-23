extends Enemy


const BULLET_SCENE = preload("uid://1huy1acvith")

const BLAZE : Array[PackedScene] = [
	preload("uid://1jlq2hixdbyy"),
	preload("uid://0b5gernd2bd1")
	]

func _process(_delta: float) -> void:
	if is_instance_valid(player) and can_move:
		var distance_to_player = (player.position - global_position).length()
		aim_raycast.target_position = player.position - global_position
		$Armature.look_at(player.global_position, Vector3.UP, false) 
		
		if aim_raycast.get_collider() == player and $Timer.is_stopped() and distance_to_player < 30:
			$Timer.start()
			shoot()
			
func shoot() -> void:
	var new_bullet : Area3D = BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	# Получаем направление взгляда игрока (вперед от камеры)
	var shoot_direction : Vector3 = -$Armature.global_transform.basis.z.normalized()
	new_bullet.launch(self, %Marker3D.global_position, shoot_direction, 30, 0.17) 
	var new_effect = BLAZE.pick_random().instantiate()
	new_bullet.components.add_child(new_effect)

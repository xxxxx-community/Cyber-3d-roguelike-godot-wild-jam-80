extends StaticBody3D


var open : bool = false

func _on_player_detector_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		open = true
		$PlayerDetector.queue_free()
		$AnimationPlayer.play(&"open")


#после зачистки комнаты активировать этот звук $doorIndicator


func _on_player_detector_2_body_entered(body: Node3D) -> void:
	if body.name == "Player" and open:
		open = false
		get_tree().current_scene.get_node("SpawnRooms").delete_room(get_parent())
		$AnimationPlayer.play(&"close")

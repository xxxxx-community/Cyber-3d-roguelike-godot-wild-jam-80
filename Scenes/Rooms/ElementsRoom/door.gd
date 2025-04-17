extends StaticBody3D


func _on_player_detector_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		$PlayerDetector.queue_free()
		$AnimationPlayer.play(&"open")


#после зачистки комнаты активировать этот звук $doorIndicator

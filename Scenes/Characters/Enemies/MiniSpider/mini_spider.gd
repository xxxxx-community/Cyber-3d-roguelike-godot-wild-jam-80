extends Enemy


func jump() -> void:
	if $Timer.is_stopped() and is_on_floor():
		$Timer.start()
		velocity.y = jump_velocity

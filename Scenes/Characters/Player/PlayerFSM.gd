extends FiniteStateMachine

func _init() -> void:
	_add_state("dead")
		
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.dead:
			animation_player.play("dead")

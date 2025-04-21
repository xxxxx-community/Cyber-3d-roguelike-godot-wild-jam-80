extends FiniteStateMachine


func _init() -> void:
	_add_state("idle")
	_add_state("move")
	_add_state("dead")
	
	
func _ready() -> void:
	set_state(states.idle)
	
	
func _state_logic(delta: float) -> void:
	if state == states.move or state == states.idle:
		parent.move()
		parent.chase()
		parent.jump()
		parent.gravity(delta)
		
func _get_transition() -> int:
	match state:
		states.idle:
			if parent.velocity.length() > 3:
				return states.move
		states.move:
			if parent.velocity.length() < 3:
				return states.idle
	return -1

	
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.move:
			animation_player.play("move", -1, 2)
		states.dead:
			$"../FireExplosion".stop()
			animation_player.play("dead")

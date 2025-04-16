extends FiniteStateMachine


func _init() -> void:
	_add_state("attack_hit")
	_add_state("attack_switch")
	_add_state("idle")
	_add_state("run")
	_add_state("walk")
	
	
func _ready() -> void:
	set_state(states.idle)
	
	
func _state_logic(delta: float) -> void:
	if state == states.walk or state == states.idle or state == states.run:
		parent.move()
		parent.chase()
		parent.gravity(delta)
		
func _get_transition() -> int:
	match state:
		states.idle:
			if parent.velocity.length() > 1:
				return states.run
		states.run:
			if parent.velocity.length() < 1:
				return states.idle
	return -1

	
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.idle:
			animation_player.play("idle")
		states.run:
			animation_player.play("run")

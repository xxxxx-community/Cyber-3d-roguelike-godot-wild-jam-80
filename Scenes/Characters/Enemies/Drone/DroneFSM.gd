extends FiniteStateMachine



func _init() -> void:
	_add_state("Attack")
	_add_state("dead")
	_add_state("Fly")
	_add_state("Switch_Attack")
	
	
func _ready() -> void:
	set_state(states.Fly)
	
	
func _state_logic(_delta: float) -> void:
	if state == states.Fly:
		parent.move()
		#parent.gravity(delta)
		
func _get_transition() -> int:
	match state:
		states.Attack:
			if not animation_player.is_playing():
				return states.Fly
		states.Switch_Attack:
			if not animation_player.is_playing():
				return states.Fly
	return -1
	
func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.Attack:
			animation_player.play("Attack")
		states.Fly:
			animation_player.play("Fly")
		states.dead:
			animation_player.play("dead")

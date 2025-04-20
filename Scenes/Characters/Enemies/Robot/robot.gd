extends Enemy


@onready var hitbox: Hitbox = %Hitbox

func _process(_delta: float) -> void:
	$rig.look_at(player.global_position, Vector3.UP, true) 
	$rig.rotation *= Vector3.UP
	if player in hitbox.get_overlapping_bodies():
		state_machine.set_state(state_machine.states.attack_hit)

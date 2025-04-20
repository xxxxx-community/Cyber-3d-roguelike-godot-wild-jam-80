class_name Character extends CharacterBody3D


const FRICTION          : float = 0.1

@export var acceleration   : float = 10.0
@onready var accel : float = acceleration
@export var jump_velocity  : float = 5.5
@export var max_health_points : float = 100.0
@export var health_points : float = 100.0: set = set_hp
signal hp_changed(new_hp)

@onready var state_machine : Node = get_node("FiniteStateMachine")

var move_direction : Vector3
var can_move : bool = true

func move() -> void:
	if move_direction and can_move:
		velocity.x = move_direction.x * accel
		velocity.z = move_direction.z * accel
		
	velocity.x = lerp(velocity.x, 0.0, FRICTION) 
	velocity.z = lerp(velocity.z, 0.0, FRICTION) 
	
func _physics_process(_delta: float) -> void:
	move_and_slide()

func gravity(delta : float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if global_position.y < -50:
			velocity.y = jump_velocity * 7

func set_hp(new_hp: float) -> void:
	health_points = clamp(new_hp, 0, max_health_points)
	emit_signal("hp_changed", health_points)
	
func take_damage(damage : float, _dir : Vector3 = Vector3.ZERO, _force : float = 0, attacker : Node3D = null) -> void:
	health_points += damage
	
	#print(attacker)
	if health_points > 0:
		pass
		#parent.state_machine.set_state(parent.state_machine.states.hurt)
	else:
		state_machine.set_state(state_machine.states.dead)
		can_move = false
		

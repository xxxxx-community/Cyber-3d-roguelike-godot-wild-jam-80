class_name Character extends CharacterBody3D


const FRICTION          : float = 0.1

@export var jump_velocity  : float = 5.0

@export var acceleration   : float = 10.0
@onready var accel : float = acceleration

@onready var state_machine : Node = get_node("FiniteStateMachine")

var move_direction : Vector3
var can_move : bool = true

func move() -> void:
	if move_direction:
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

class_name Character extends CharacterBody3D


const MOUSE_SENSITIVITY : float = 0.01
const FRICTION          : float = 0.1

@export var acceleration   : float = 10.0
var accel : float = acceleration
@export var jump_velocity  : float = 5.5
@export var max_health_ponts : int = 5
@export var health_ponts : int = 5: set = set_hp
signal hp_changed(new_hp)

var move_direction : Vector3

func move() -> void:
	accel = acceleration
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

func set_hp(new_hp: int) -> void:
	health_ponts = clamp(new_hp, 0, max_health_ponts)
	emit_signal("hp_changed", health_ponts)
	

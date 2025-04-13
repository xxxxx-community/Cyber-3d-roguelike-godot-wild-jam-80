class_name Character extends CharacterBody3D


const SPEED             : float = 5.0
const JUMP_VELOCITY     : float = 5.5
const MOUSE_SENSITIVITY : float = 0.01
const FRICTION          : float = 0.1

var move_direction : Vector3

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func move() -> void:
	if move_direction:
		velocity.x = move_direction.x * SPEED
		velocity.z = move_direction.z * SPEED
		
	velocity.x = lerp(velocity.x, 0.0, FRICTION) 
	velocity.z = lerp(velocity.z, 0.0, FRICTION) 
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	move()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if global_position.y < -50:
			velocity.y = JUMP_VELOCITY * 7

class_name Character extends CharacterBody3D



const MOUSE_SENSITIVITY : float = 0.01
const FRICTION          : float = 0.1

@export var max_health_ponts: int = 5
@export var health_ponts: int = 5: set = set_hp
signal hp_changed(new_hp)

var move_direction : Vector3
var speed : float = 10.0
var jump_velocity : float = 5.5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func move() -> void:
	if move_direction:
		velocity.x = move_direction.x * speed
		velocity.z = move_direction.z * speed
		
	velocity.x = lerp(velocity.x, 0.0, FRICTION) 
	velocity.z = lerp(velocity.z, 0.0, FRICTION) 
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	move()
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
		if global_position.y < -50:
			velocity.y = jump_velocity * 7

func set_hp(new_hp: int) -> void:
	health_ponts = clamp(new_hp, 0, max_health_ponts)
	emit_signal("hp_changed", health_ponts)
	

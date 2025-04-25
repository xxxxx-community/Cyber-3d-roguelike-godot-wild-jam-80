extends Character


const MOUSE_SENSITIVITY : float = 0.01

#fov variables
const BASE_FOV = 100.0
const FOV_CHANGE = 1.5

#bob variables
const BOB_FREQ : float = 2.4
const BOB_AMP : float = 0.0

@onready var camera : Camera3D = get_node(^"%Camera3D")
@onready var body   : Node3D = get_node(^"Body")

var swing : float = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion and can_move:
		body.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	super(delta)
	if can_move:
		# Handle Jump.
		if Input.is_action_just_pressed(&"ui_select") and is_on_floor():
			velocity.y = jump_velocity
			
		var input_dir : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		move_direction = (body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
		# Head bob
		swing += delta * velocity.length() * int(is_on_floor())
		camera.transform.origin = _headbob(swing)
		
		# движение ружья вперёд
		var velocity_clamped : float = clamp(velocity.length(), 0.5, accel * 3)
		var target_fov : float = BASE_FOV + FOV_CHANGE * velocity_clamped
		camera.fov = lerp(camera.fov, target_fov, delta * 8.0)

#кочание при хождении
func _headbob(time) -> Vector3:
	var pos : Vector3 = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	
func _process(delta: float) -> void:
	move()
	gravity(delta)

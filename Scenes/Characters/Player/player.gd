extends Character


const BULLET_SCENE : PackedScene = preload("res://Scenes/Projectiles/projectile.tscn")
const MOUSE_SENSITIVITY : float = 0.01

@onready var head = $Body/Head
@onready var model  : MeshInstance3D = get_node(^"Body")
@onready var camera : Camera3D = get_node(^"%Camera3D")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var concrete_sound_steps: AudioStreamPlayer3D = $footstepsSounds/ConcreteSoundSteps
@onready var shoot_sound: AudioStreamPlayer = %shootSound

var is_moving : bool = false
var footstep_timer : float = 0.0
const BASE_FOOTSTEP_INTERVAL = 0.1  # Базовый интервал для ходьбы
const SPRINT_FOOTSTEP_INTERVAL = 0.02  # Интервал для бега
var current_interval := BASE_FOOTSTEP_INTERVAL
#bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 100.0
const FOV_CHANGE = 1.5


func _ready():
	%shader_mesh.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion and can_move:
		model.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	# Handle Jump.
	if Input.is_action_just_pressed(&"ui_select") and is_on_floor() and can_move:
		velocity.y = jump_velocity
	
	# Handle Sprint.
	if Input.is_action_pressed("sprint") and can_move:
		accel = acceleration * 1.5
	else:
		accel = acceleration

	# Get the input direction and handle the movement/deceleration.
	var input_dir : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	move_direction = (model.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


#region Звук

	#Определяем текущий интервал в зависимости от скорости
	current_interval = (
		SPRINT_FOOTSTEP_INTERVAL if Input.is_action_pressed("sprint") 
		else BASE_FOOTSTEP_INTERVAL
	)
# Воспроизведение звука шагов
	var was_moving = is_moving
	is_moving = is_on_floor() && move_direction.length() > 0.1 && velocity.length() > 0.1

	if is_moving:
		footstep_timer += delta
		if footstep_timer >= current_interval:
			play_footstep_sound()
			footstep_timer = 0.0
	else:
		footstep_timer = 0.0
		if was_moving:
			concrete_sound_steps.stop()
				
#endregion

	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, acceleration * 1.5 * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()
#кочание при хождении
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func play_footstep_sound():
	if not concrete_sound_steps.playing:
		concrete_sound_steps.pitch_scale = randf_range(0.9, 1.1)  # Случайная высота тона для разнообразия
		concrete_sound_steps.play()

func _process(delta: float) -> void:
	gravity(delta)
	move()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not animation_player.is_playing() and can_move:
		animation_player.play(&"recoil")
		shoot_sound.play()
		shoot()
		
func shoot() -> void:
	var new_bullet : Area3D = BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	# Получаем направление взгляда игрока (вперед от камеры)
	var shoot_direction : Vector3 = -camera.global_transform.basis.z.normalized()
	new_bullet.launch(self, %Marker3D.global_position, shoot_direction, 20, 0.1) 

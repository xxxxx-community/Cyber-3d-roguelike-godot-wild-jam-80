extends Character


const PROJECTILE : PackedScene = preload("res://Scenes/ECS/Projectiles/projectile.tscn")
const MOUSE_SENSITIVITY : float = 0.01

#fov variables
const BASE_FOV = 100.0
const FOV_CHANGE = 1.5

#bob variables
const BOB_FREQ : float = 2.4 * 1.2
const BOB_AMP : float = 0.08

@onready var camera : Camera3D = get_node(^"%Camera3D")
@onready var body   : Node3D = get_node(^"Body")
@onready var sound_steps : AudioStreamPlayer3D = get_node(^"SoundSteps")
@onready var animation_player : AnimationPlayer = get_node(^"AnimationPlayer")

var swing : float = 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if can_move:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and not animation_player.is_playing():
				animation_player.play(&"recoil")
				shoot()
				
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and (event is InputEventMouseMotion):
			body.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
			camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _physics_process(delta: float) -> void:
	super(delta)
	if can_move:
			
		var input_dir : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		move_direction = (body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
			
		if is_on_floor():
			# Handle Jump.
			if Input.is_action_just_pressed(&"ui_select"):
				velocity.y = jump_velocity
				
			# Качание головой
			swing += delta * velocity.length()
			var camera_swing : Vector3 = _headbob(swing)
			
			camera.transform.origin = camera_swing
			
			# При опускании камеры в самый низ по синусу -> воспроизводим звук шагов
			if camera_swing.y <= 0.02 - BOB_AMP:
				swing += 0.1
				play_footstep_sound()
				
		else:
			# При этом X камера ниже всего, чтобы был звук падения
			swing = 1.5
			
		# ускорение
		if Input.is_action_pressed(&"shift"):
			accel = acceleration * 2
		else:
			accel = acceleration
		
		# движение ружья вперёд
		var velocity_clamped : float = clamp(velocity.length(), 0.5, accel * 3)
		var target_fov : float = BASE_FOV + FOV_CHANGE * velocity_clamped
		camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
		

#качание при хождении
func _headbob(time) -> Vector3:
	var pos : Vector3 = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

func play_footstep_sound() -> void:
	if not sound_steps.playing:
		sound_steps.pitch_scale = randf_range(0.9, 1.1)  # Случайная высота тона для разнообразия
		sound_steps.play()
		
func shoot() -> void:
	var new_bullet : Area3D = PROJECTILE.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	
	# Получаем направление взгляда игрока (вперед от камеры)
	var shoot_direction : Vector3 = -camera.global_transform.basis.z.normalized()
	new_bullet.launch(self, %Marker3D.global_position, shoot_direction, 30) 
	
func _process(delta: float) -> void:
	move()
	gravity(delta)

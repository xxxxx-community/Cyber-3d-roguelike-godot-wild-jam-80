extends Character


const BULLET_SCENE : PackedScene = preload("res://Scenes/Projectiles/projectile.tscn")

@onready var body   : MeshInstance3D = get_node(^"Body")
@onready var camera : Camera3D = get_node(^"%Camera3D")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var max_hp = 100
var hp = 75
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _input(event) -> void:
	if is_on_floor():
		# Прыжок
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = jump_velocity * 2
		
	var input_dir : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	move_direction = (body.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and event is InputEventMouseMotion:
		body.rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		camera.rotate_x(-event.relative.y * MOUSE_SENSITIVITY)
		
	camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
	
func _process(delta: float) -> void:
	gravity(delta)
	move()
	update_health_bar()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and not animation_player.is_playing():
		animation_player.play(&"recoil")
		shoot()
		

func shoot() -> void:
	var new_bullet : Area3D = BULLET_SCENE.instantiate()
	get_tree().current_scene.add_child(new_bullet)
	# Получаем направление взгляда игрока (вперед от камеры)
	var shoot_direction : Vector3 = -camera.global_transform.basis.z.normalized()
	new_bullet.launch(self, %Marker3D.global_position, shoot_direction, 5, 0.1) 
	
func update_health_bar():
	var health_bar = $Body/Camera3D/Health_bar/Sprite3D/SubViewport/ProgressBar
	if health_bar:
		health_bar.value = (hp/float(max_hp))*100

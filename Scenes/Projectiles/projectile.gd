class_name Projectile extends Hitbox


@onready var collision_shape_3d : CollisionShape3D = $CollisionShape3D
@onready var components : Node3D = $Components

var projectile_speed : int
var attacker_entity : Node3D

func launch(attacker : Node3D, pos : Vector3, dir : Vector3 = Vector3.ZERO, speed : int = 10, spread_angle : float = 0.0):
	attacker_entity = attacker
	position = pos
	knockback_direction = dir
	projectile_speed = speed 
	
	  # Применяем разброс к направлению
	if spread_angle > 0:
		knockback_direction = _apply_spread(dir, spread_angle).normalized()
	else:
		knockback_direction = dir.normalized()
	rotation = dir

# Применяем случайное отклонение к направлению
func _apply_spread(base_dir: Vector3, angle: float) -> Vector3:
	# Создаем случайное отклонение в пределах конуса
	var random_angle_x : float = randf_range(-angle, angle)
	var random_angle_y : float = randf_range(-angle, angle)
	
	# Создаем базовую ориентацию
	@warning_ignore("shadowed_variable_base_class")
	var basis : Basis = Basis()
	
	# Поворачиваем вокруг осей
	basis = basis.rotated(Vector3.RIGHT, random_angle_x)
	basis = basis.rotated(Vector3.UP, random_angle_y)
	
	# Применяем поворот к исходному направлению
	return basis * base_dir
	
func _physics_process(delta):
	position += knockback_direction * projectile_speed * delta 

func _collide(body: Node3D) -> void:
	if body.name != "Player":
		projectile_speed = 0
		
		for comp in components.get_children():
			comp.stop()
			
		$AnimationPlayer.play(&"dead")
		

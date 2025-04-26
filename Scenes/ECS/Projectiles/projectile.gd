extends Area3D


@onready var collision_shape_3d : CollisionShape3D = get_node(^"CollisionShape3D")

var projectile_speed : int
var attacker_entity : Node3D
var deading : bool = true
var knockback_direction : Vector3

func launch(attacker : Node3D, pos : Vector3, dir : Vector3 = Vector3.ZERO, speed : int = 10, spread_angle : float = 0.0):
	attacker_entity = attacker
	position = pos
	knockback_direction = dir
	projectile_speed = speed 
	
	  # Применяем разброс к направлению
	if spread_angle > 0:
		knockback_direction = _apply_spread(dir, spread_angle).normalized()
		
	rotation = knockback_direction

# Применяем случайное отклонение к направлению
func _apply_spread(base_dir: Vector3, angle: float) -> Vector3:
	# Создаем случайное отклонение в пределах конуса
	var random_angle_x : float = randf_range(-angle, angle)
	var random_angle_y : float = randf_range(-angle, angle)
	
	# Поворачиваем вокруг осей
	basis = basis.rotated(Vector3.RIGHT, random_angle_x)
	basis = basis.rotated(Vector3.UP, random_angle_y)
	
	# Применяем поворот к исходному направлению
	return basis * base_dir
	
func _physics_process(delta):
	position += knockback_direction * projectile_speed * delta 
	
	var player_pos : Vector3 = get_tree().current_scene.get_node("Player").global_position
	var distance : float = global_position.distance_to(player_pos)
	if distance > 100:
		queue_free()

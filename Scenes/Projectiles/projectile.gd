class_name Projectile extends Area3D


@onready var mesh_instance_3d : MeshInstance3D = $MeshInstance3D
@onready var collision_shape_3d : CollisionShape3D = $CollisionShape3D

var move_direction : Vector3
var projectile_speed : int
var deading : bool = true

func launch(pos : Vector3, dir : Vector3 = Vector3.ZERO, speed : int = 10, spread_angle : float = 0.0):
	position = pos
	move_direction = dir
	projectile_speed = speed 
	
	  # Применяем разброс к направлению
	if spread_angle > 0:
		move_direction = _apply_spread(dir, spread_angle).normalized()
	else:
		move_direction = dir.normalized()
	rotation = dir

# Применяем случайное отклонение к направлению
func _apply_spread(base_dir: Vector3, angle: float) -> Vector3:
	# Создаем случайное отклонение в пределах конуса
	var random_angle_x : float = randf_range(-angle, angle)
	var random_angle_y : float = randf_range(-angle, angle)
	
	# Создаем базовую ориентацию
	var basis : Basis = Basis()
	
	# Поворачиваем вокруг осей
	basis = basis.rotated(Vector3.RIGHT, random_angle_x)
	basis = basis.rotated(Vector3.UP, random_angle_y)
	
	# Применяем поворот к исходному направлению
	return basis * base_dir
	
func _physics_process(delta):
	position += move_direction * projectile_speed * delta 

func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		mesh_instance_3d.hide()
		collision_shape_3d.set_deferred("disabled", true)
		projectile_speed = 0
		
		for comp in $Components.get_children():
			comp.stop()
		
		if deading:
			await get_tree().create_timer(1).timeout
			queue_free()

class_name Projectile extends Area3D


var move_direction : Vector3
var projectile_speed : int

func launch(pos : Vector3, dir : Vector3 = Vector3.ZERO, speed : int = 10):
	position = pos
	move_direction = dir
	projectile_speed = speed 
	rotation = dir
	
func _physics_process(delta):
	position += move_direction * projectile_speed * delta 

func _on_body_entered(body: Node3D) -> void:
	if body.name != "Player":
		queue_free()

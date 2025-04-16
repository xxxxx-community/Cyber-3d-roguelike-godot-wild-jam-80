extends Component


func _ready() -> void:
	$Timer.start()
	
func _on_timer_timeout() -> void:
	if not parent_projectile.get_node("Components").has_node("BlackHoleComponent"):
		var new_bullet : Area3D = parent_projectile.duplicate()
		get_tree().current_scene.add_child(new_bullet)
		new_bullet.launch(self, global_position, parent_projectile.rotation, parent_projectile.projectile_speed, 0.3) 

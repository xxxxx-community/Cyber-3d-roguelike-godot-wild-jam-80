extends Component


func _on_timer_timeout() -> void:
	var new_bullet : Area3D = parent_projectile.duplicate()
	get_tree().current_scene.add_child(new_bullet)
	new_bullet.get_node(^"Components/ComponentDublicate/Timer").start()
	new_bullet.launch(global_position, parent_projectile.rotation, parent_projectile.projectile_speed, 0.3) 

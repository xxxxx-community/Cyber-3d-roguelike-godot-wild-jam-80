class_name Hitbox extends Area3D 


@export var damage : float = -1
@export var delay_attack : float = 0.5
@export var knockback_force : float = 10
var knockback_direction : Vector3 = Vector3.ZERO

@onready var collision : CollisionShape3D = get_child(0)
var timer     : Timer = Timer.new()

var body_inside : bool = false

func _init():
	var __ = connect("body_entered", Callable(self, "_on_body_entered"))
	__ = connect("body_exited", Callable(self, "_on_body_exited"))
	
func _ready():
	add_child(timer)
	timer.autostart = true
	# Ошибка если нету коллизии
	assert(collision != null)
	
func _on_body_entered(body):
	body_inside = true
	timer.start(delay_attack)
	# Пока зона урона внутри тела, будет наноситься урон с частотой в timer
	while body_inside:
		if not is_instance_valid(body):
			return
		if body in get_overlapping_bodies():
			_collide(body)
		await timer.timeout

func _on_body_exited(_body):
	body_inside = false
	timer.stop()

func _collide(body) -> void:
	if body.has_method("take_damage") and body != owner:
		body.take_damage(damage, knockback_direction, knockback_force, owner)

class_name Hitbox extends Area3D 


@export var damage : float = -1
@export var delay_attack : float = 0.5
var knockback_direction : Vector3 = Vector3.ZERO

@onready var collision : CollisionShape3D = get_node("CollisionShape3D")
var timer_delay_damage : Timer = Timer.new()

var body_inside : bool = false

func _ready():
	var __ = connect("body_entered", Callable(self, "_on_body_entered"))
	__ = connect("body_exited", Callable(self, "_on_body_exited"))
	add_child(timer_delay_damage)
	timer_delay_damage.autostart = true
	# Ошибка если нету коллизии
	assert(collision != null)
	
func _on_body_entered(body):
	body_inside = true
	timer_delay_damage.start(delay_attack)
	
	# Пока зона урона внутри тела, будет наноситься урон с частотой в timer_delay_damage
	while body_inside:
		if not is_instance_valid(body):
			return
		_collide(body)
		await timer_delay_damage.timeout

func _on_body_exited(_body):
	body_inside = false
	timer_delay_damage.stop()
	
func _collide(body) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage, knockback_direction)

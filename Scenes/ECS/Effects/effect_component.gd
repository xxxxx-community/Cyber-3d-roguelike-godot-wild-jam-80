class_name EffectComponent extends Hitbox


@onready var carrier_effect : Node = get_parent().get_parent()

var can_collide : bool = true
	
func stop() -> void:
	if has_node("GPUParticles3D"):
		$GPUParticles3D.emitting = false

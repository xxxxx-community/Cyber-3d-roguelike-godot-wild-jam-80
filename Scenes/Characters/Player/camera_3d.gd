extends Camera3D

# Noise parameters
@export var noise = FastNoiseLite.new()
@export var noise_intensity = .1
@export var noise_scale = .25
@export var top_level_time = true
var time = 0.0
var rotation_shake = Vector3(0, 0, 0)
var value_strength = 0
func _ready():
	self.current = true

func _process(delta):
	time += delta

	# Use different time offsets for x and y to get independent noise values
	var time_offset_x = 10000.0  # Large offset for x
	var time_offset_y = 20000.0  # Different large offset for y

	# Generate smooth noise values
	var noise_x = noise.get_noise_2d(time + time_offset_x, 0) * noise_intensity
	var noise_y = noise.get_noise_2d(time + time_offset_y, 1) * noise_intensity
	var desired_h_offset = noise_x * noise_scale
	var desired_v_offset = noise_y * noise_scale
		
	h_offset = desired_h_offset + ((random_rotation()) * .5).y
	v_offset = desired_v_offset + ((random_rotation()) * .5).x
	value_strength = lerpf(value_strength, 0, .03)
	# Apply noise to the camera's rotation

func shake_camera(value):
	value_strength = value

func random_rotation():
	return Vector3(randf_range(-value_strength, value_strength), randf_range(-value_strength, value_strength), randf_range(-value_strength, value_strength)) * .01

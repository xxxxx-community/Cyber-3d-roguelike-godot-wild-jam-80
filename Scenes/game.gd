extends Node3D

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var directional_light: DirectionalLight3D = $DirectionalLight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ultra()

func ultra() -> void:
	get_viewport().use_taa = true
	get_viewport().msaa_3d = Viewport.MSAA_2X
	get_viewport().screen_space_aa = 0 as Viewport.ScreenSpaceAA
	get_viewport().positional_shadow_atlas_size = 8192
	get_viewport().mesh_lod_threshold = 0.0
	RenderingServer.directional_shadow_atlas_set_size(8192, true)
	RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_HIGH)
	RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_HIGH)
	RenderingServer.gi_set_use_half_resolution(false)
	RenderingServer.environment_glow_set_use_bicubic_upscale(true)
	RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_MEDIUM, true, 0.5, 2, 50, 300)
	RenderingServer.environment_set_ssil_quality(RenderingServer.ENV_SSIL_QUALITY_MEDIUM, true, 0.5, 4, 50, 300)
	RenderingServer.environment_set_volumetric_fog_filter_active(true)

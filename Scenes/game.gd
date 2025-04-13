extends Node3D

@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var directional_light: DirectionalLight3D = $DirectionalLight

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ultra()

func ultra() -> void:
	#get_viewport().use_taa = true
	get_viewport().msaa_3d = Viewport.MSAA_2X
	get_viewport().screen_space_aa = 0 as Viewport.ScreenSpaceAA
	RenderingServer.directional_shadow_atlas_set_size(8192, true)
	directional_light.shadow_bias = 0.01
	get_viewport().positional_shadow_atlas_size = 8192
	RenderingServer.directional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_HIGH)
	RenderingServer.positional_soft_shadow_filter_set_quality(RenderingServer.SHADOW_QUALITY_SOFT_HIGH)
	get_viewport().mesh_lod_threshold = 0.0
	world_environment.environment.sdfgi_enabled = true
	RenderingServer.gi_set_use_half_resolution(false)
	world_environment.environment.glow_enabled = true
	RenderingServer.environment_glow_set_use_bicubic_upscale(true)
	world_environment.environment.ssao_enabled = true
	RenderingServer.environment_set_ssao_quality(RenderingServer.ENV_SSAO_QUALITY_MEDIUM, true, 0.5, 2, 50, 300)
	world_environment.environment.set_ssr_enabled(true)
	world_environment.environment.set_ssr_max_steps(56)
	world_environment.environment.ssil_enabled = true
	RenderingServer.environment_set_ssil_quality(RenderingServer.ENV_SSIL_QUALITY_MEDIUM, true, 0.5, 4, 50, 300)
	#world_environment.environment.fog_enabled = true
	#world_environment.environment.volumetric_fog_enabled = true
	#RenderingServer.environment_set_volumetric_fog_filter_active(true)

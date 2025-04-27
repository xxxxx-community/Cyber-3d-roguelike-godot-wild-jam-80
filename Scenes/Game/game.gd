extends Node3D


func _ready() -> void:
	get_viewport().use_taa = true
	get_viewport().msaa_3d = Viewport.MSAA_2X
	get_viewport().screen_space_aa = 0 as Viewport.ScreenSpaceAA
	get_viewport().positional_shadow_atlas_size = 8192
	get_viewport().mesh_lod_threshold = 0.0

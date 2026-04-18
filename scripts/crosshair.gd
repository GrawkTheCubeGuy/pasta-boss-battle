extends TextureRect

@export var normal_texture : Texture2D
@export var interact_texture : Texture2D
@export var raycaster : RayCast3D
var use_interact_texture : bool = false

func _process(_delta: float) -> void:
	texture = interact_texture if use_interact_texture else normal_texture
	use_interact_texture = false if not raycaster.get_collider() is BossObject or raycaster.get_collider() is PastaCollider else true

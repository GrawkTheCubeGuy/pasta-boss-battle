extends Sprite2D

func _ready() -> void:
	if not global.dark_souls_mode:
		queue_free()

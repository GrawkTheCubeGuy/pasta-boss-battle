extends Camera2D

func _process(_delta: float) -> void:
	zoom.x = 1 + (get_viewport().size.x / 1152.0) / 100
	zoom.y = 1 + (get_viewport().size.y / 648.0) / 100

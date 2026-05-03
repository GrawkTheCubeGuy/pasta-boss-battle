extends Control

func _process(_delta: float) -> void:
	global_position = Vector2(get_viewport().size / 2)
	print(global_position)

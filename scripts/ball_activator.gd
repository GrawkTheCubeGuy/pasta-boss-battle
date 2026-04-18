extends Node

func _ready() -> void:
	get_parent()._on_pressed()
	get_parent().self_modulate = Color(1.0, 1.0, 1.0)

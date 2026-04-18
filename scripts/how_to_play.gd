extends Control

var last_button : int = 1

func _on_button_pressed(button: int) -> void:
	get_child(last_button).get_child(0).visible = false
	get_child(button).get_child(0).visible = true
	last_button = button

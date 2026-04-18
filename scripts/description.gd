extends RichTextLabel

func _process(_delta: float) -> void:
	global_position = Vector2(get_viewport().get_mouse_position().x + 960, get_viewport().get_mouse_position().y - 100)
	
func _on_ball_button_mouse_entered() -> void:
	visible = true

func _on_ball_button_mouse_exited() -> void:
	visible = false

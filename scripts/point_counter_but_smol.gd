extends RichTextLabel


func _process(_delta: float) -> void:
	if get_parent().get_script() != null:
		text = str("Point Cost : ", get_parent().point_cost)

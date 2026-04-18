extends RichTextLabel


func _process(_delta: float) -> void:
	text = str("Point Cost : ", get_parent().point_cost)

extends RichTextLabel

func _process(_delta: float) -> void:
	text = str("Points : ", global.points)

extends RichTextLabel

func _ready() -> void:
	var high_score = FileAccess.open("res://endless_high_score.txt", FileAccess.READ).get_as_text()
	if high_score == "":
		high_score = "None"
	self.text = str("High Score: ", high_score)

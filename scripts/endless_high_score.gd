extends RichTextLabel

func _ready() -> void:
	var high_score = FileAccess.open("res://endless_high_score.txt", FileAccess.READ)
	if high_score == null:
		var high_score_writable = FileAccess.open("res://endless_high_score.txt", FileAccess.WRITE)
		high_score_writable.store_string("")
		high_score = FileAccess.open("res://endless_high_score.txt", FileAccess.READ)
	if high_score.get_as_text() == "":
		high_score = "None"
	else:
		high_score = high_score.get_as_text()
	self.text = str("High Score: ", high_score)

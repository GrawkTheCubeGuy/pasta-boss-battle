extends RichTextLabel

func _ready() -> void:
	var high_score = SaveManager.save_data.endless_high_score
	var text_displayed : String
	if high_score <= 0:
		text_displayed = "None"
	else:
		text_displayed = str("Wave ", high_score)
	text = str("High Score : ", text_displayed)
#	var high_score = FileAccess.open("user://endless_high_score.txt", FileAccess.READ)
#	if high_score == null:
#		var high_score_writable = FileAccess.open("user://endless_high_score.txt", FileAccess.WRITE)
#		high_score_writable.store_string("")
#		high_score = FileAccess.open("user://endless_high_score.txt", FileAccess.READ)
#	if high_score.get_as_text() == "":
#		high_score = "None"
#	else:
#		high_score = high_score.get_as_text()
#	self.text = str("High Score: ", high_score)

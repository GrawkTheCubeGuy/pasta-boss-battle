extends Control

func _ready() -> void:
	var text_file = FileAccess.open("res://save.txt", FileAccess.READ)
	if text_file == null:
		var text_file_writable = FileAccess.open("res://save.txt", FileAccess.WRITE)
		text_file_writable.store_string('["red ball", "light blue ball", "orange ball"]')
		text_file = FileAccess.open("res://save.txt", FileAccess.READ)
	var file : Array = str_to_var(text_file.get_as_text())
	for variable in file:
		for child in get_children():
			if child.name == variable:
				child._on_pressed()
	var has_beat_darksoul_mode : FileAccess = FileAccess.open("res://beat.txt", FileAccess.READ)
	if has_beat_darksoul_mode == null or str_to_var(has_beat_darksoul_mode.get_as_text()) == false:
		$"rainbow ball".texture_normal = load("res://ball/locked ball.tres")
		$"rainbow ball".set_script(null)
		$"rainbow ball/description".text = "THIS BALL IS NOT UNLOCKED YET!"

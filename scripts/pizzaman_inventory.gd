extends Control

func _ready() -> void:
	for i in SaveManager.save_data.pizzaman_inventory:
		if has_node(i):
			find_child(i).add_thyself()
	if not SaveManager.save_data.has_beat_ds_mode == true:
		$"rainbow ball".texture_normal = load("res://ball/locked ball.tres")
		$"rainbow ball".set_script(null)
		$"rainbow ball/description".text = "THIS BALL IS NOT UNLOCKED YET!"
#	var text_file = FileAccess.open("user://save.txt", FileAccess.READ)
#	if text_file == null or text_file == "":
#		var text_file_writable = FileAccess.open("user://save.txt", FileAccess.WRITE)
#		text_file_writable.store_string('["red ball", "light blue ball", "orange ball"]')
#		text_file = FileAccess.open("user://save.txt", FileAccess.READ)
#	var file : Array = str_to_var(text_file.get_as_text())
#	for variable in file:
#	var has_beat_darksoul_mode : FileAccess = FileAccess.open("user://beat.txt", FileAccess.READ)
#	if has_beat_darksoul_mode == null or str_to_var(has_beat_darksoul_mode.get_as_text()) == false:
#		$"rainbow ball".texture_normal = load("res://ball/locked ball.tres")
#		$"rainbow ball".set_script(null)
#		$"rainbow ball/description".text = "THIS BALL IS NOT UNLOCKED YET!"

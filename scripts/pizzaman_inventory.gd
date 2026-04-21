extends Control

func _ready() -> void:
	var file : Array = str_to_var(FileAccess.open("res://save.txt", FileAccess.READ).get_as_text())
	for variable in file:
		for child in get_children():
			if child.name == variable:
				child._on_pressed()
	var has_beat_darksoul_mode : bool = str_to_var(FileAccess.open("res://beat.txt", FileAccess.READ).get_as_text())
	if not has_beat_darksoul_mode:
		$"rainbow ball".texture_normal = load("res://ball/locked ball.tres")
		$"rainbow ball".set_script(null)
		$"rainbow ball/description".text = "THIS BALL IS NOT UNLOCKED YET!"

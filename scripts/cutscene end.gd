extends AudioStreamPlayer

func _on_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/chase_sequence.tscn")


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip cutscene"):
		_on_finished()

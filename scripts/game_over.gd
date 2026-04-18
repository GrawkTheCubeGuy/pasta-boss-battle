extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("restart"):
		global.health = 1.0
		global.change_health()
		print(global.scene_retuner)
		get_tree().change_scene_to_file(global.scene_retuner)

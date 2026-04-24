extends AnimationPlayer

func _ready() -> void:
	if global.dark_souls_mode:
		$"../secret concluding text".text = "Check your ball collection ;)"
	play("boot")

func _on_animation_finished(_anim_name: StringName) -> void:
	var load_file = FileAccess.open("res://beat.txt", FileAccess.READ)
	var acutal_file = FileAccess.open("res://beat.txt", FileAccess.WRITE)
	if global.dark_souls_mode:
		acutal_file.store_string("true")
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip cutscene"):
		_on_animation_finished("")

extends AnimationPlayer

func _ready() -> void:
	play("boot")

func _on_animation_finished(_anim_name: StringName) -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip cutscene"):
		_on_animation_finished("")

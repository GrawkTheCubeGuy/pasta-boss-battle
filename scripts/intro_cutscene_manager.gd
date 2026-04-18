extends Node3D

@onready var camera2d : Camera2D = $node/camera
@onready var camera3d : Camera3D = $camera
@onready var animation : AnimationPlayer = $animation

func _ready() -> void:
	load("res://scenes/arena.tscn")
	animation.play("cutscene")

func _switch_camera() -> void:
	$node.queue_free()


func _on_animation_animation_finished(_anim_name: StringName) -> void:
	if global.speedrun:
		SpeedrunTimerScript.speedrun_start()
	if global.endless:
		var wave_counter = load("res://scenes/wave counter.tscn").instantiate()
		global.add_child(wave_counter)
	get_tree().change_scene_to_file("res://scenes/arena.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("skip cutscene"):
		_on_animation_animation_finished("")

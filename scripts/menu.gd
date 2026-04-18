extends Control

const cheat_code_array : Array = ["Up", "Up", "Down", "Down", "Left", "Right", "Left", "Right", "B", "A"]
var key_array : Array 
var is_menu_h2p : bool = false
@onready var cam : Camera2D = $cam
@onready var animation : AnimationPlayer = $animation


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	animation.play("bootup")

func _on_how_to_play_pressed() -> void:
	if not is_menu_h2p:
		animation.play("thing")
	else:
		animation.play("thing_backwards")
	is_menu_h2p = not is_menu_h2p

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/opening cutscene.tscn")

func _on_endless_pressed() -> void:
	global.endless = true
	global.dark_souls_mode = false
	get_tree().change_scene_to_file("res://scenes/opening cutscene.tscn")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		key_array.append(event.as_text())
	if key_array.size() > cheat_code_array.size():
		if not global.dark_souls_mode:
			key_array.remove_at(0)
	if key_array == cheat_code_array:
		dark_souls_mode()
		key_array = ["NO MORE DARK SOULS MODE >:("]
		
		
func dark_souls_mode() -> void:
	global.dark_souls_mode = true
	$"dark souls mode".play()
	$"title screen/play".texture_normal = load("res://images/dark souls button.png")
	$overlay.visible = true
	$"title screen/background music".stop()
	$"title screen/endless".queue_free()
	for i in 255:
		$overlay.modulate.a8 -= 1
		$"really fuck me timer".start(0.016)
		await $"really fuck me timer".timeout
	$overlay.visible = false
func _on_pizazaman_inventroy_pressed() -> void:
	animation.play("pizzaman_inventory")

func _on_back_arrow_pressed() -> void:
	animation.play("pizzaman_inventory_back")

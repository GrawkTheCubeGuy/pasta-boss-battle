extends TextureButton

@onready var pressed_texture = load("res://images/speedrun timer on.png")
@onready var unpressed_texture = load("res://images/speedrun timer off.png")

var on : bool = false

func _on_pressed() -> void:
	on = not on
	if on:
		texture_normal = pressed_texture
	else:
		texture_normal = unpressed_texture

func _on_play_pressed() -> void:
	if on:
		global.speedrun = true

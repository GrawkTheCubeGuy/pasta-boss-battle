extends Control
class_name NextUp

var ball_array : Array = global.ball_inventory

@onready var start_pos = position
@onready var ball_displayer : TextureRect = $ball
@export var player : Player
var ball_index : int = 0
var ball_index_max : int = ball_array.size() -1
var ball_index_min : int  = 0
var on_screen : bool = false
var ball

func _ready() -> void:
	if ball_array == []:
		self.queue_free()
		return
	ball = ball_array[0]
	player.cur_pizzaman_ball = ball
	for i in ball_array:
		load(str("res://ball/", i, ".tres"))
	print(ball_array)
	print(ball_index_max)
	set_ball()
	

func _process(_delta: float) -> void:
	if not on_screen:
		position.y = lerp(position.y, start_pos.y, 0.3)
	else:
		position.y = lerp(position.y, start_pos.y + 170, 0.3)
	
		
		if Input.is_action_just_pressed("ball left"):
			ball_index -= 1
			set_ball_index()
			
		if Input.is_action_just_pressed("ball right"):
			ball_index += 1
			set_ball_index()
			

func _on_object_holder_weapon_switched(weapon : String) -> void:
	if weapon == "pizzaman":
		on_screen = true
	else:
		on_screen = false
		

func set_ball_index() -> void:
	if ball_index > ball_index_max:
		ball_index = ball_index_min
		
	if ball_index < ball_index_min:
		ball_index = ball_index_max
	
	ball = ball_array[ball_index]
	player.cur_pizzaman_ball = ball
	set_ball()
	
func set_ball() -> void:
	ball_displayer.texture = load(str("res://ball/", ball, ".tres"))
	

func _on_object_holder_pizzaman_fire() -> void:
	match ball:
		"fucking peak":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(1, 0, 0, 1))
		"bob":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(0.2, 0.2, 0.2, 1))
		"vamp":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(1, 0, 1, 1))
		"heavy ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(0, 0, 0, 1))
		"poison":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(0, 1, 0, 1))
		"red ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(1, 0, 0, 1))
		"light blue ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(0, 1, 1, 1))
		"orange ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(1, 0.478, 0, 1))
		"yellow ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(1, 1, 0, 1))
		"green ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(0, 1, 0, 1))
		"blue ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(0, 0, 1, 1))
		"pink ball":
			RenderingServer.global_shader_parameter_set("pizzaman_eye_color", Vector4(1.0, 0.48, 0.987, 1.0))

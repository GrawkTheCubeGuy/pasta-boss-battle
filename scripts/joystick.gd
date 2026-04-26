extends Control
class_name Joystick

@export var joystick : Control
@export var up_max : Control
@export var down_max : Control
@export var left_max : Control
@export var right_max : Control
@export var right_max_but_better : Control
var is_held : bool = false
var finger_location : Vector2 = Vector2.ZERO


func _process(_delta: float) -> void:
	if not Input.is_action_pressed("hold"):
		reset_velocity()
		return
	finger_location = get_viewport().get_mouse_position()
	if finger_location.x > right_max_but_better.position.x:
		reset_velocity()
		return
	joystick.global_position = Vector2(finger_location.x -50, finger_location.y -50)
	internalize_joystick()
	var y_ratio = (joystick.position.y / 100) - 0.5
	var x_ratio = (joystick.position.x / 100) - 0.5
	if y_ratio > 0:
		Input.action_press("backward", y_ratio)
	else:
		Input.action_press("forward", -y_ratio)
	if x_ratio > 0:
		Input.action_press("right", x_ratio)
	else:
		Input.action_press("left", -x_ratio)

func internalize_joystick() -> void:
	if joystick.global_position.x > right_max.global_position.x:
		joystick.global_position.x = right_max.global_position.x
	if joystick.global_position.x < left_max.global_position.x:
		joystick.global_position.x = left_max.global_position.x
	if joystick.global_position.y > down_max.global_position.y:
		joystick.global_position.y = down_max.global_position.y
	if joystick.global_position.y < up_max.global_position.y:
		joystick.global_position.y = up_max.global_position.y

func reset_velocity() -> void:
	Input.action_release("backward")
	Input.action_release("forward")
	Input.action_release("left")
	Input.action_release("right")
	joystick.position = Vector2(50, 50)
	

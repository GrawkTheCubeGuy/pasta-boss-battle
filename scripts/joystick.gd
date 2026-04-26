extends Control
class_name Joystick

@export var joystick : Control
@export var up_max : Control
@export var down_max : Control
@export var left_max : Control
@export var right_max : Control
@export var up_command : String
@export var down_command : String
@export var left_command : String
@export var right_command : String
@export var right_max_but_better : Control
@export var left_max_but_better : Control
var is_held : bool = false
var finger_location : Vector2 = Vector2.ZERO


func _input(event: InputEvent) -> void:
	if not event is InputEventScreenDrag:
		reset_velocity()
		return
	finger_location = event.position
	if finger_location.x > right_max_but_better.global_position.x:
		reset_velocity()
		return
	if finger_location.x < left_max_but_better.global_position.x:
		reset_velocity()
		return
	joystick.global_position = Vector2(finger_location.x -50, finger_location.y -50)
	internalize_joystick()
	var y_ratio = (joystick.position.y / 100) - 0.5
	var x_ratio = (joystick.position.x / 100) - 0.5
	if y_ratio > 0:
		Input.action_press(down_command, y_ratio)
	else:
		Input.action_press(up_command, -y_ratio)
	if x_ratio > 0:
		Input.action_press(right_command, x_ratio)
	else:
		Input.action_press(left_command, -x_ratio)

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
	Input.action_release(down_command)
	Input.action_release(up_command)
	Input.action_release(left_command)
	Input.action_release(right_command)
	joystick.position = Vector2(50, 50)
	

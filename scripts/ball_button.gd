extends TextureButton
class_name BallButton 

@export var point_cost : int
@export var ball : String
var on : bool = false

func _init() -> void:
	self_modulate = Color(0.314, 0.314, 0.314, 1.0)

func check_if_on() -> void:
	if on:
		if not point_cost > global.points:
			global.ball_inventory.append(ball)
			global.points -= point_cost
			self_modulate = Color(1.0, 1.0, 1.0)
		else:
			on = false
	else:
		for i in global.ball_inventory.size():
			if global.ball_inventory[i] == ball:
				global.ball_inventory.remove_at(i)
				break
		self_modulate = Color(0.314, 0.314, 0.314, 1.0)
		global.points += point_cost

func _on_pressed() -> void:
	on = not on
	check_if_on()

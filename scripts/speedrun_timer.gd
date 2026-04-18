extends Label
class_name SpeedrunTimer

@export var stop : bool = false
@export var timer : Timer
@export var max_value : int = 59
var value : float = 0
@export var value_increase : float = 1

func _ready() -> void:
	timer.timeout.connect(increase_self)
	
func increase_self() ->  void:
	if !stop:
		value += value_increase
		if value > max_value:
			value = 0
		if value < 10:
			text = str("0", int(value))
		else:
			text = str(int(value))
		

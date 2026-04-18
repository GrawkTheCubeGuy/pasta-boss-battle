extends Sprite3D
class_name ExplosionSprite

@onready var timer : Timer = $timer

func appear_and_vanish() -> void:
	modulate.a = 0
	for i in 9:
		modulate.a += 0.1
		timer.start(0.01)
		await timer.timeout
	for i in 19:
		modulate.a -= 0.05
		timer.start(0.01)
		await timer.timeout
	
	

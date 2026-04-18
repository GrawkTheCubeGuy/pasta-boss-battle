extends Node3D

@export var player : Player
@onready var timer : Timer = $Timer
var fucking_forever = 9223372036854775807

func _ready() -> void:
	var virtue = load("res://scenes/virtue.tscn")
	var bullet = load("res://scenes/pasta_parent.tscn")
	var hammer = load("res://scenes/pasta_hammer.tscn")
	var instantiated
	var random_number : int
	timer.start()
	await timer.timeout
	for i in fucking_forever:
		random_number = randi_range(1, 3)
		instantiated = null
		if random_number == 1:
			instantiated = bullet.instantiate()
			get_parent().add_child(instantiated)
			instantiated.get_child(0).player = player
			instantiated.get_child(0).fire()
		elif random_number == 2:
			instantiated = hammer.instantiate()
			get_parent().add_child(instantiated)
			instantiated.player = player
			instantiated.fire()
		elif random_number == 3:
			instantiated = virtue.instantiate()
			get_parent().add_child(instantiated)
			instantiated.player = player
			instantiated.fire()

		instantiated = null
		timer.start()
		await timer.timeout

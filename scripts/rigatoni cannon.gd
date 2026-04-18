extends BossObject

@onready var fuck_me: Timer = $"fuck me timer"
var should_look : bool = false
var user : Player

func _ready() -> void:
	pass

func _on_area_body_entered(body: Node3D) -> void:
	if body is Player:
		should_look = true
		user = body
		_attack()
		
func _on_area_body_exited(body: Node3D) -> void:
	if body is Player:
		should_look = false

func _attack() -> void:
	if should_look:
		var look_point = Vector3(user.position.x, position.y, user.position.z)
		look_at(look_point)
		create_attack("bullet", 5, 0.15)
		fuck_me.start(10)
		await fuck_me.timeout
		_attack()

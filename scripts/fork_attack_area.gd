extends Area3D

@onready var collis : CollisionShape3D = $collis
@onready var timer : Timer = $timer

func _on_object_holder_fork_attack() -> void:
	collis.disabled = false
	timer.start()
	await timer.timeout
	collis.disabled = true

func _on_body_entered(body: Node3D) -> void:
	if body is BossObject:
		global.deal_damage_player(-0.03)
		global.deal_damage(20)
	

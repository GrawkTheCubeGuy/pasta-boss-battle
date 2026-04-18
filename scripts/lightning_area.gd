extends Area3D

@onready var timer : Timer = $timer
@onready var player_timer : Timer = $"player timer"
var is_boss_inside : bool = false
var is_player_inside : bool = false
var damage : int = 20

func _on_body_entered(body: Node3D) -> void:
	if body is BossObject:
		is_boss_inside = true
		global.deal_damage(damage)
		timer.start(1)
	elif body is Player:
		is_player_inside = true
		global.deal_damage_player(0.34)
		player_timer.start(0.5)

func _on_body_exited(body: Node3D) -> void:
	if body is BossObject:
		is_boss_inside = false
	elif body is BossObject:
		is_player_inside = false

func _on_timer_timeout() -> void:
	if is_boss_inside:
		global.deal_damage(damage)
		
func _on_player_timer_timeout() -> void:
	if is_player_inside:
		global.deal_damage_player(0.34)

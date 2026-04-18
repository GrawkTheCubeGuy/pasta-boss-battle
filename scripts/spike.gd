extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		global.deal_damage_player(0.5)

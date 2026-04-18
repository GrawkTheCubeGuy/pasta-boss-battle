extends Node3D
class_name Hammer

@onready var collis : CollisionShape3D = $area/collis
@export var animation : AnimationPlayer 
@export var player : Player 

func fire() -> void:
	await ready
	position = player.position
	animation.play("hammer attack")
	await animation.animation_finished
	call_deferred("queue_free")
	
func _on_area_body_entered(body: Node3D) -> void:
	if body is Player:
		print("hammer hit player")
		call_deferred("disable_collision")
		global.deal_damage_player(0.4)

func disable_collision() -> void:
	collis.disabled = true

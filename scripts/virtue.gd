extends Node3D
class_name Virtue

@onready var collis : CollisionShape3D = $area/collis
@onready var mesh : Node3D = $area/mesh
@export var animation : AnimationPlayer 
@export var player : Player 

func fire() -> void:
	await ready
	position = player.position
	animation.play("become real")
	await animation.animation_finished
	call_deferred("queue_free")
	
func _on_area_body_entered(body: Node3D) -> void:
	if body is Player:
		print("virtue hit player")
		call_deferred("disable_collision")
		global.deal_damage_player(0.2)

func disable_collision() -> void:
	collis.disabled = true

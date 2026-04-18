extends Node3D
class_name Bullet

@onready var animator : AnimationPlayer = $animator
@onready var timer : Timer = $timer
@onready var follow_node : Node3D = $follow
@export var player : Player 
@export var speed : float = -0.2
var follow : bool = false
var move : bool = false


func fire() -> void:
	await ready
	speed += randf_range(-0.09, 0.09)
	follow_node.position.z = speed
	animator.play("pasta_shot")
	await animator.animation_finished
	visible = true
	follow = true
	move = true
	timer.start()

func _process(_delta) -> void:
	if follow:
		look_at(player.global_position)
	if move:
		global_position = follow_node.global_position

func _on_area_body_entered(body: Node3D) -> void:
	if body.name == "player":
		if not player.is_shielded:
			print("bullet hit player")
			global.deal_damage_player(0.15)
		call_deferred("queue_free")

func _on_timer_timeout() -> void:
	follow = false

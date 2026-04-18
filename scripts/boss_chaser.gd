extends Area3D

@export var speed : float = 0.5

@onready var tentacle_array : Array[AnimationPlayer] = [
$"pasta tentacle/AnimationPlayer", 
$"pasta tentacle2/AnimationPlayer",
$"pasta tentacle3/AnimationPlayer",
$"pasta tentacle4/AnimationPlayer"
]

func _ready() -> void:
	for i in tentacle_array:
		i.play("ArmatureAction_001")
	

func _process(delta: float) -> void:
	position.z -= speed * (delta / 0.016)


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		global.deal_damage_player(100)

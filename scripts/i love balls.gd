extends Sprite3D

@onready var tentacle_array : Array[AnimationPlayer] = [
$"pasta tentacle/AnimationPlayer", 
$"pasta tentacle2/AnimationPlayer",
$"pasta tentacle3/AnimationPlayer",
$"pasta tentacle4/AnimationPlayer"
]

func _ready() -> void:
	for i in tentacle_array:
		i.play("ArmatureAction_001")

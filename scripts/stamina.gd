extends Control

@export var player : Player 
@onready var deadline : ColorRect = $deathline

func _process(_delta: float) -> void:
	deadline.size.x = player.stamina * 37.5

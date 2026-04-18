extends Control

var milliseconds : SpeedrunTimer = load("res://scenes/speedrun_timer_milliseconds.tscn").instantiate()
var seconds  : SpeedrunTimer = load("res://scenes//speedrun_timer_seconds.tscn").instantiate()
var minutes  : SpeedrunTimer = load("res://scenes//speedrun_timer_minutes.tscn").instantiate()
var is_speedrun : bool = false

func _ready() -> void:
	z_index = 4096

func speedrun_start() -> void:
	is_speedrun = true
	add_child(milliseconds)
	add_child(seconds)
	add_child(minutes)

func speedrun_end() -> void:
	if is_speedrun:
		milliseconds.stop = true
		seconds.stop = true
		minutes.stop = true

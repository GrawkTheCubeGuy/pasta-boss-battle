extends Node

signal endless_wave_ended

var max_boss_health : int = 1000
var health :float = 1.0
var boss_health :int = max_boss_health
var scene_retuner
var speedrun : bool = false
var endless : bool = false
var endless_wave : int = 0
var dark_souls_mode : bool = false
var points : int = 10
var ball_inventory : Array 

func deal_damage(amount : int) -> void:
	boss_health -= amount
	RenderingServer.global_shader_parameter_set("boss_healthbar", (boss_health / float(max_boss_health)) * 0.6228)
	if boss_health <= 0:
		if not endless:
			get_tree().call_deferred("change_scene_to_file", "res://scenes/phase_transition_cutscene.tscn")
		else:
			change_endless_wave()

func deal_damage_player(damage : float) -> void:
	if not dark_souls_mode:
		health -= damage 
	else:
		if health > 0:
			health -= damage * 2
		else:
			health -= damage
	if health <= 0:
		scene_retuner = get_tree().current_scene.scene_file_path
		boss_health = max_boss_health
		RenderingServer.global_shader_parameter_set("boss_healthbar", 1)
		if endless:
			var prev_high_score = FileAccess.open("res://endless_high_score.txt", FileAccess.READ).get_as_text()
			if prev_high_score == "":
				prev_high_score = -1
			else:
				prev_high_score = int(prev_high_score.replace("Wave ", ""))
			var file : FileAccess = FileAccess.open("res://endless_high_score.txt", FileAccess.WRITE)
			if prev_high_score < endless_wave:
				var pretty_endless_wave : String = str("Wave ", endless_wave)
				print(pretty_endless_wave)
				file.store_string(pretty_endless_wave)
			get_tree().call_deferred("change_scene_to_file", "res://scenes/menu.tscn")
		else:
			get_tree().call_deferred("change_scene_to_file", "res://scenes/game_over.tscn")
	if health > 1:
		health = 1
	change_health()
	

func change_health() -> void:
	RenderingServer.global_shader_parameter_set("healthbar_clip", health)


func change_endless_wave() -> void:
	endless_wave += 1
	boss_health = max_boss_health
	emit_signal("endless_wave_ended")
	
	

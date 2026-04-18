extends CharacterBody3D
class_name BossObject

var stun_counter : int = 0
var stun_requirement : int = 0
@export var scene_root : Node3D 
@export var speed : float = 1
@export var player : Player
@export var attack_timer : Timer 
@export var cooldown_timer : Timer
@export var attack_one_timer : Timer 
@export var animator : AnimationPlayer 
@export var poison_particle : CPUParticles3D 
@onready var timer_array : Array[Timer] = [
	attack_timer,
	cooldown_timer,
	attack_one_timer
]
@onready var hammer = load("res://scenes/pasta_hammer.tscn")
@onready var bullet = load("res://scenes/pasta_parent.tscn")
@onready var beam = load("res://scenes/virtue.tscn")

func _ready() -> void:
	global.endless_wave_ended.connect(increase_speed)
	stun_requirement = randi_range(3, 5)
	if global.dark_souls_mode:
		global.max_boss_health = 1500
		global.boss_health = global.max_boss_health 
		for i in timer_array:
			i.wait_time /= 2
		speed = 1.5
		animator.speed_scale *= speed 
	boss_logic()
	

func create_attack(attack : String, amount : int = 1, wait_time : float = 0) -> void:
	var instantiated = null 
	if global.endless_wave == 0:
		pass
	else:
		for i in global.endless_wave:
			wait_time -= wait_time / 20
	match attack:
		"bullet":
			for i in amount:
				instantiated = bullet.instantiate()
				scene_root.call_deferred("add_child", instantiated)
				instantiated.position = position
				instantiated.get_child(0).player = player
				instantiated.get_child(0).speed *= speed
				instantiated.get_child(0).fire()
				attack_timer.start(wait_time)
				await attack_timer.timeout
		"virtue":
			for i in amount:
				instantiated = beam.instantiate()
				scene_root.call_deferred("add_child", instantiated)
				instantiated.position = position
				instantiated.player = player
				instantiated.animation.speed_scale *= 1 + (speed / 8)
				instantiated.fire()
				attack_timer.start(wait_time)
				await attack_timer.timeout
		"hammer":
			for i in amount:
				instantiated = hammer.instantiate()
				scene_root.call_deferred("add_child", instantiated)
				instantiated.player = player
				instantiated.animation.speed_scale *= 1+(speed / 8)
				instantiated.fire()
				attack_timer.start(wait_time)
				await attack_timer.timeout

func boss_logic() -> void:
	animator.play("passive move around")
	attack_logic()
	
func attack_logic() -> void:
	if stun_counter >= stun_requirement:
		animator.play("stun")
		await animator.animation_finished
		animator.play("passive move around")
		stun_requirement = randi_range(3, 5)
		stun_counter = 0
	if animator.current_animation == "stun":
		await animator.animation_finished
	cooldown_timer.start(randf_range(4, 6))
	await cooldown_timer.timeout
	var attack : int = randi_range(1, 3)
	if attack == 1:
		animator.speed_scale = set_speed_scale(5)
		for i in randi_range(3, 5):
			if animator.current_animation == "stun":
				break
			animator.speed_scale = set_speed_scale(0.5)
			create_attack("bullet", 7, 0.15)
			attack_one_timer.start(1.05)
			await attack_one_timer.timeout
			animator.speed_scale = set_speed_scale(5)
			attack_one_timer.start(1.5)
			await attack_one_timer.timeout
		animator.speed_scale = set_speed_scale(1)
	elif attack == 2:
		create_attack("virtue", randi_range(20, 25), 0.2)
	else:
		create_attack("hammer", 2, 8)
	
	stun_counter += 1
	attack_logic()

func set_speed_scale(speed_scale : float) -> float:
	return speed_scale * speed

func emit_poison_particles() -> void:
	poison_particle.emitting = true

func dont_emit_poison_particles() -> void:
	poison_particle.emitting = false

func increase_speed() -> void:
	speed += speed / 20
	for i in timer_array:
		i.wait_time -= i.wait_time / 20
	stun_counter = 0
	stun_requirement = randi_range(3, 5)
	boss_logic()

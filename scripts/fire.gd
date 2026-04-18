extends RayCast3D

signal boss_entered
signal boss_exited

@onready var yellow_ball_animator : AnimatedSprite2D = $"../yellow ball indicator"
var has_boss_entered : bool 
var is_yellow_ball_firing : bool = false 
var yellow_ball_amount : int = 0 
var orange_ball_array : Array[LightningRod]
@export var player : Player
@onready var yellow_ball_timer : Timer = $"yellow ball timer"
@onready var blue_ball_timer : Timer = $"blue ball timer"
@onready var collis_explosion : CollisionShape3D = $"../explosion area/collis"
@onready var collis_area : Area3D = $"../explosion area"
@onready var poison_timer : Timer = $"../poison timer"
@onready var timer : Timer = $"../explosion timer"
@onready var explosion : ExplosionSprite = $"../explosion"
@export var boss : BossObject
@onready var rod = load("res://scenes/lightning_rod.tscn")
@onready var lightning = load("res://scenes/lightning.tscn")
@export var scene_root : Node3D
var poison_count : int = 0
const max_poison_count : int = 20
var hit_boss : bool = false
var has_explosion_checked : bool = false
var lightning_mesh : Lightning

func _process(_delta) -> void:
	if is_colliding():
		if get_collider() is BossObject:
			has_boss_entered = true
			emit_signal("boss_entered")
		else: 
			if has_boss_entered:
				emit_signal("boss_exited")
	else:
		if has_boss_entered:
			emit_signal("boss_exited")

func _on_object_holder_pizzaman_fire() -> void:
	hit_boss = false
	if not is_colliding():
		return
	else:
		if get_collider() is BossObject: ##UNUSED
			match player.cur_pizzaman_ball:
				"fucking peak":
					global.deal_damage(6)
				"bob":
					global.deal_damage(2)
					hit_boss = true
				"vamp":
					global.deal_damage(1)
					global.deal_damage_player(-0.04)
				"poison":
					boss.emit_poison_particles()
					poison_count = 0
					poison_timer.start()
		match player.cur_pizzaman_ball:
			"orange ball":
				if get_collider().name == "ground":
					orange_ball_logic(true)
			"blue ball":
					blue_ball_logic()
		if get_collider() is BossObject:
			match player.cur_pizzaman_ball:
				"light blue ball":
					sniper_ball_logic()
				"red ball":
					red_ball_logic()
				"yellow ball":
					yellow_ball_logic()
				"green ball":
					green_ball_logic()

func _on_explosion_area_body_entered(body: Node3D) -> void:
	if body.name == "pasta static":
		body.get_parent().get_parent().call_deferred("queue_free")
	if body is BossObject:
		if not hit_boss:
			global.deal_damage(20)
	if body is Player:
		global.deal_damage_player(0.5)

func _on_posion_timer_timeout() -> void:
	poison_count += 1
	global.deal_damage(4)
	if poison_count == max_poison_count:
		boss.dont_emit_poison_particles()
		poison_timer.stop()

func calculate_distance(value1 : float, value2 : float) -> float:
	if value1 < 0 and value2 < 0 :
		return abs(abs(value1) - abs(value2))
	if value1 > 0 and value2 > 0:
		return abs(abs(value1) - abs(value2))
	if value1 < 0:
		return (abs(value1) + value2)
	if value2 < 0:
		return (abs(value2) + value1)
	return 0

func orange_ball_logic(add_rod : bool = false) -> void:
	var new_rod : LightningRod 
	if add_rod:
		new_rod = rod.instantiate()	
		scene_root.add_child(new_rod)
		new_rod.global_position = get_collision_point()
		orange_ball_array.append(new_rod)
	if not lightning_mesh == null:
		lightning_mesh.queue_free()
	if orange_ball_array.size() == 1:
		return
	lightning_mesh = lightning.instantiate()
	scene_root.add_child(lightning_mesh)
	if orange_ball_array.size() == 3:
		orange_ball_array[0].queue_free()
		orange_ball_array.remove_at(0)
	var distance_y = calculate_distance(new_rod.position.y, orange_ball_array[0].position.y)
	var distance_x = calculate_distance(new_rod.position.x, orange_ball_array[0].position.x)
	var distance_z = calculate_distance(new_rod.position.z, orange_ball_array[0].position.z)
	var hipotenuse = sqrt(abs(distance_x) * abs(distance_x) + abs(distance_y) * abs(distance_y) + abs(distance_z) * abs(distance_z))
	lightning_mesh.scale.z = hipotenuse
	lightning_mesh.global_position = new_rod.global_position
	lightning_mesh.look_at(orange_ball_array[0].global_position)
	lightning_mesh.global_position = lightning_mesh.sloppy_joe.global_position

func remove_lightning_mesh(the_rod : LightningRod) -> void:
	if not lightning_mesh == null:
		for i in orange_ball_array.size() - 1:
			if orange_ball_array[i] == the_rod:
				orange_ball_array.remove_at(i)
		the_rod.queue_free()
		lightning_mesh.queue_free()
		lightning_mesh = null

func sniper_ball_logic() -> void:
	var distance_vector : Vector3 = Vector3(calculate_distance(player.position.x, boss.position.x), calculate_distance(player.position.y, boss.position.y), calculate_distance(player.position.z, boss.position.z))
	var distance_line : float = sqrt(distance_vector.x * distance_vector.x + distance_vector.y * distance_vector.y + distance_vector.z * distance_vector.z)
	if distance_vector.y > 2:
		if distance_line < 26:
			global.deal_damage(25)
		elif distance_line < 35:
			global.deal_damage(7)
		elif distance_line < 50: 
			global.deal_damage(5)
		else:
			return
	else:
		global.deal_damage(5)

func red_ball_logic() -> void:
	global.deal_damage(15)

func yellow_ball_logic() -> void:
	is_yellow_ball_firing = true
	yellow_ball_animator.visible = true
	yellow_ball_animator.play("stage 1")
	yellow_ball_timer.start()
	await boss_exited
	yellow_ball_timer.stop()
	yellow_ball_amount = 0 
	yellow_ball_animator.visible = false

func _on_yellow_ball_timer_timeout() -> void:
	if is_yellow_ball_firing:
		yellow_ball_amount += 1
	if yellow_ball_amount >= 60:
		global.deal_damage(10)
		if not yellow_ball_animator.animation == "stage 3":
			yellow_ball_animator.animation = "stage 3"
			yellow_ball_animator.play()
	elif yellow_ball_amount >= 30:
		if not yellow_ball_animator.animation == "stage 2":
			yellow_ball_animator.animation = "stage 2"
			yellow_ball_animator.play()
		global.deal_damage(3)
	elif yellow_ball_amount >= 15:
		if not yellow_ball_animator.animation == "stage 1":
			yellow_ball_animator.animation = "stage 1"
			yellow_ball_animator.play()
		global.deal_damage(1)

func green_ball_logic() -> void:
	player.stamina += 8
	global.deal_damage(7)

func blue_ball_logic() -> void:
	var raycast_2 : RayCast3D = self.duplicate()
	raycast_2.set_script(null)
	scene_root.add_child(raycast_2)
	raycast_2.global_transform = global_transform
	blue_ball_timer.start(1)
	await blue_ball_timer.timeout
	if raycast_2.is_colliding():
		if raycast_2.get_collider() is BossObject:
			global.deal_damage(40)
	raycast_2.queue_free()

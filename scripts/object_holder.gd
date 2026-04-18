extends Control
class_name ObjectHolder

signal weapon_switched
signal pizzaman_fire
signal cube_shield
signal fork_attack
signal mrman_dash

@export var animation_player : AnimationPlayer
@export var item_texture : Sprite2D
@export_enum("fork", "pizzaman", "cube", "mrman") var cur_item : String = "fork"
var item_array : Array = ["fork", "pizzaman", "cube", "mrman"]
var item_index : int = 0
var item_index_max : int = 3
var item_index_min : int = 0
var animation_player_is_playing_animation : bool = false
var is_shielded : bool = false
var can_use_pizzaman : bool = true
var can_use_mr_man : bool = true
@onready var pizzaman_timer : Timer = $"pizzaman timer"
@onready var mr_man_timer : Timer = $"mr man timer"
@onready var fork : Texture2D = load("res://images/fork.png")
@onready var pizzaman : Texture2D = load("res://images/pizzaman.png")
@onready var cube : Texture2D = load("res://images/cubert.png")
@onready var mrman : Texture2D = load("res://images/mr man.png")

func _ready() -> void:
	item_texture.texture = fork
	animation_player.play("bounce")
	
func _process(_delta: float) -> void:
	
	if Input.is_action_just_released("scroll down") and not is_shielded:
		item_index -= 1
		set_item_index()
		set_weapon(item_array[item_index])
		
	if Input.is_action_just_released("scroll up") and not is_shielded:
		item_index += 1
		set_item_index()
		set_weapon(item_array[item_index])
		
	if Input.is_action_just_released("one") and not is_shielded:
		switch_weapon("fork")
		item_index = 0
		
	if Input.is_action_just_released("two") and not is_shielded:
		switch_weapon("pizzaman")
		item_index = 1
		
	if Input.is_action_just_released("three") and not is_shielded:
		switch_weapon("cube")
		item_index = 2
		
	if Input.is_action_just_released("four") and not is_shielded:
		switch_weapon("mrman")
	
	if Input.is_action_just_pressed("use") and not animation_player_is_playing_animation:
		animation_player_is_playing_animation = true
		match cur_item:
			"fork":
				
				emit_signal("fork_attack")
				animation_player.play("attack")
				await animation_player.animation_finished
				animation_player.play("bounce")
			"pizzaman":
				
				if get_parent().cur_pizzaman_ball == "":
					$pizzaman.visible = true
					$"idiot timer".start()
				else:
					if can_use_pizzaman:
						can_use_pizzaman = false
						pizzaman_timer.start()
						emit_signal("pizzaman_fire")
						animation_player.play("shoot")
						await animation_player.animation_finished
						animation_player.play("bounce")
			"cube":
				animation_player_is_playing_animation = false
				if not is_shielded:
					emit_signal("cube_shield")
					is_shielded = true
					animation_player.play("shield")
				else:
					emit_signal("cube_shield")
					animation_player.play_backwards("shield")
					await animation_player.animation_finished
					is_shielded = false
					animation_player.play("bounce")
			"mrman":
				
				if can_use_mr_man:
					can_use_mr_man = false
					mr_man_timer.start()
					emit_signal("mrman_dash")
					animation_player.play("whirl")
					await animation_player.animation_finished
					animation_player.play("bounce")
		animation_player_is_playing_animation = false

func switch_weapon(weapon : String) -> void:
	cur_item = weapon
	set_weapon(weapon)
	
func set_weapon(weapon : String) -> void:
	set_item_index()
	cur_item = weapon
	match weapon:
		"fork":
			emit_signal("weapon_switched", "fork")
			item_texture.texture = fork
		"pizzaman":
			emit_signal("weapon_switched", "pizzaman")
			item_texture.texture = pizzaman
		"cube":
			emit_signal("weapon_switched", "cube")
			item_texture.texture = cube
		"mrman":
			emit_signal("weapon_switched", "mrman")
			item_texture.texture = mrman
	animation_player.play("switch weapon")
	await animation_player.animation_finished
	animation_player.play("bounce")
	
func set_item_index() -> void:
	if item_index > item_index_max:
	
		item_index = item_index_min
		
	if item_index < item_index_min:
		
		item_index = item_index_max
		
	match item_index:
		0:
			cur_item = "fork"
		1:
			cur_item = "pizzaman"
		2:
			cur_item = "cube"
		3:
			cur_item = "mrman"


func _on_pizzaman_timer_timeout() -> void:
	can_use_pizzaman = true


func _on_mr_man_timer_timeout() -> void:
	can_use_mr_man = true

func _on_idiot_timer_timeout() -> void:
	$pizzaman.visible = false

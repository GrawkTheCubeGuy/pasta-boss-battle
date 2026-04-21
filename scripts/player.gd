extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SENSITIVITY : float = 0.2
@export var is_shielded : bool = false
var is_sliding : bool = false
var is_running : bool = false
@export var stamina : float = 20
@export var max_stamina : float = 20
@export var min_stamina : float = 0
@export var cur_pizzaman_ball : String 

@onready var camera : Camera3D = $camera
@onready var raycast : RayCast3D = $camera/teleport

func _ready() -> void:
	global.health = 1
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Check sliding
	if Input.is_action_pressed("slide"):
		is_sliding = true
		scale = Vector3(0.5, 0.5, 0.5)
	else:
		is_sliding = false
		scale = Vector3(1, 1, 1)
		
	if Input.is_action_pressed("run") and not is_shielded and not stamina == min_stamina:
		is_running = true
		if not stamina < min_stamina:
			stamina -= 0.2
		else:
			stamina = min_stamina
	else:
		is_running = false
		if not Input.is_action_pressed("run"):
			if not stamina > max_stamina:
				stamina += 0.1

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if not is_sliding:
		if input_dir:
			velocity.x = direction.x * SPEED * (int(is_running) +1) / (int(is_shielded) + 1) #<- this just doubles speed if you're holding the run button and halves it when shielded
			velocity.z = direction.z * SPEED * (int(is_running) +1) / (int(is_shielded) + 1) #<- this just doubles speed if you're holding the run button and halves it when shielded
		else:
			if is_on_floor():
				velocity.x = move_toward(velocity.x, 0, SPEED / 5)
				velocity.z = move_toward(velocity.z, 0, SPEED / 5)
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED / 100)
				velocity.z = move_toward(velocity.z, 0, SPEED / 100)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED / 500) #<- this makes you lose velocity slower
		velocity.z = move_toward(velocity.z, 0, SPEED / 500) #<- this makes you lose velocity slower
	
	var cam_input_dir := Input.get_vector("camera_right", "camera_left", "camera_down", "camera_up")
	rotation_degrees.y += cam_input_dir.x * SENSITIVITY * 10
	rotation_degrees.x += cam_input_dir.y * SENSITIVITY * 10
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * SENSITIVITY 
		camera.rotation_degrees.x -= event.relative.y * SENSITIVITY
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90 , 90)

func _on_object_holder_cube_shield() -> void:
	is_shielded = not is_shielded

func _on_object_holder_mrman_dash() -> void:
	position = raycast.get_collision_point()

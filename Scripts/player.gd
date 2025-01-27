extends CharacterBody2D
class_name Player

# Instancable variables
@export var speed: float = 1600
@export var default_camera_zoom: float = 0.5

# Children
@onready var sprite = $Sprite
@onready var camera = $Camera
@onready var ui = $UI

# Movement
const ASPECT_RATIO = 2

# Health & Mana
var regen_factor = 1 # set to 0 on damage
var regen_recovery = 0.1 # recovery speed of regen after damage
var health_regen = 1
var max_health = 100
var health = max_health
var mana_regen = 60
var max_mana = 100
var mana = max_mana

# Camera
const zoom_increments = 3
const zoom_speed = 0.1
@onready var max_zoom = 2 * default_camera_zoom
@onready var min_zoom = default_camera_zoom
@onready var target_zoom = default_camera_zoom # used for smoothing zooming

# Set defaults
func _ready() -> void:
	camera.zoom = Vector2(default_camera_zoom, default_camera_zoom)
	sprite.play("idle")

# Update every frame
func _process(delta: float) -> void:
	
	# check inputs
	if Input.is_action_just_pressed("Test") && mana >= 10:
		sprite.play("attack_2")
		mana -= 10
		regen_factor = 0
	elif Input.is_action_just_released("Test"):
		sprite.play("idle")
	elif Input.is_action_just_pressed("zoom_in"):
		target_zoom = min(target_zoom + default_camera_zoom / zoom_increments, max_zoom)
	elif Input.is_action_just_pressed("zoom_out"):
		target_zoom = max(target_zoom - default_camera_zoom / zoom_increments, min_zoom)
		
	# zoom in/out smoothly
	camera.zoom = camera.zoom.lerp(Vector2(target_zoom, target_zoom), zoom_speed)
	
	move_and_collide(get_direction() * speed * delta)

func _physics_process(delta: float) -> void:
	# Health and mana regen (stop at full)
	health = min(health + health_regen * delta * regen_factor, max_health)
	mana = min(mana + mana_regen * delta * regen_factor, max_mana)
	regen_factor = min(regen_factor + regen_recovery * delta, 1)
	
	ui.max_health = max_health
	ui.health = health
	ui.max_mana = max_mana
	ui.mana = mana

# Get isometric input direction
func get_direction() -> Vector2:
	var direction = Input.get_vector("WalkLeft", "WalkRight", "WalkUp", "WalkDown")
	
	# Normalise, accounting for isometric
	direction.x *= 2
	direction = direction.normalized()
	
	return direction

func teleport_to(destination: Vector2) -> void:
	position = destination
	$Camera.reset_smoothing()

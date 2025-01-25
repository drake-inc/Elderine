extends CharacterBody2D
class_name Player

# Instancable variables
@export var speed: float
@export var camera_zoom: float

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


# Set defaults
func _ready() -> void:
	camera.zoom = Vector2(camera_zoom, camera_zoom)
	sprite.play("idle")

# Update every frame
func _process(delta: float) -> void:
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

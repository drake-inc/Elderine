extends CharacterBody2D


# Instance
@export var texture: Texture
@export var speed: float
@export var camera_zoom: float

# Movement
const ASPECT_RATIO = 2
const DISTORTION_FACTOR = 1 / cos(PI / 6) #magic number

# Health & Mana
var regen_factor = 1 # set to 0 on damage
var regen_recovery = 0.1 # recovery speed of regen after damage
var health_regen = 1
var max_health = 100
var health = max_health
var mana_regen = 60
var max_mana = 100
var mana = max_mana


func _ready() -> void:
	$Camera.zoom = Vector2(camera_zoom, camera_zoom)
	$Sprite.texture = texture


# Update character every frame
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	
	# Get movement direction
	if Input.is_action_pressed("WalkUp"):
		direction.y -= 1
	if Input.is_action_pressed("WalkDown"):
		direction.y += 1
	if Input.is_action_pressed("WalkLeft"):
		direction.x -= ASPECT_RATIO / DISTORTION_FACTOR
	if Input.is_action_pressed("WalkRight"):
		direction.x += ASPECT_RATIO / DISTORTION_FACTOR
	if Input.is_action_just_pressed("Test"):
		health = max(health - 3, 0)
		mana = max(mana - 10, 0)
		regen_factor = 0
	
	# Normalise, accounting for isometric
	direction = direction.normalized()
	direction.x *= DISTORTION_FACTOR
	
	move_and_collide(direction * speed * delta)
	

func _physics_process(delta: float) -> void:
	# Health and mana regen (stop at full)
	health = min(health + health_regen * delta * regen_factor, max_health)
	mana = min(mana + mana_regen * delta * regen_factor, max_mana)
	regen_factor = min(regen_factor + regen_recovery * delta, 1)
	
	$UI.max_health = max_health
	$UI.health = health
	$UI.max_mana = max_mana
	$UI.mana = mana

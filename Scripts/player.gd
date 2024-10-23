extends CharacterBody2D


@export var texture: Texture
@export var speed: float
@export var camera_zoom: float
const ASPECT_RATIO = 2
const DISTORTION_FACTOR = 1 / cos(PI / 6) #magic number


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
	
	# Normalise, accounting for isometric
	direction = direction.normalized()
	direction.x *= DISTORTION_FACTOR
	
	move_and_collide(direction * speed * delta)

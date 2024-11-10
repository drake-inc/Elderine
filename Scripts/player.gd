extends CharacterBody2D


# Instancable variables
@export var texture: Texture
@export var speed: float
@export var camera_zoom: float


# Magic number
const DISTORTION = 1 / cos(PI / 6)


# Set defaults
func _ready() -> void:
	$Camera.zoom = Vector2(camera_zoom, camera_zoom)
	$Sprite.texture = texture


# Update every frame
func _process(delta: float) -> void:
	move_and_collide(get_direction() * speed * delta)


# Get isometric input direction
func get_direction() -> Vector2:
	var direction = Input.get_vector("WalkLeft", "WalkRight", "WalkUp", "WalkDown")
	
	# Normalise, accounting for isometric
	direction.x *= 2 / DISTORTION
	direction = direction.normalized()
	direction.x *= DISTORTION
	
	return direction

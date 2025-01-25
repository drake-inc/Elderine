extends Area2D

@export var levelID: int
@export var destinationPosition: Vector2

var used: bool = false

func _ready() -> void:
	# Hide debug sprite in game
	$DebugSprite.visible = false

func _on_body_entered(body: Node2D):
	# Swap level if a player has entered the door
	if !used and body == GameManager.player:
		used = true
		GameManager.swap_level(levelID, destinationPosition)

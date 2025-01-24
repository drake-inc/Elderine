extends Area2D

@export var levelID: int

func _ready() -> void:
	$DebugSprite.visible = false

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		GameManager.swap_level(levelID)

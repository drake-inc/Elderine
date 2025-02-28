extends Area2D

var is_erupting = false
var cooldown = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cooldown = random_cooldown()

func _physics_process(delta: float) -> void:
	if is_erupting:
		cooldown -= delta
		
		if cooldown <= 0:
			$Sprite.play("erupt")
			cooldown = random_cooldown()
			print(random_cooldown())

func _on_body_entered(_body: Node2D) -> void:
	is_erupting = true


func _on_body_exited(_body: Node2D) -> void:
	is_erupting = false

func random_cooldown() -> float:
	return (randf() * 4) + 3

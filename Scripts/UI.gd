extends CanvasLayer

@export var health: float
@export var max_health: float
@export var mana: float
@export var max_mana: float

func _physics_process(_delta: float) -> void:
	$Health.value = health
	$Health.max_value = max_health
	$Mana.value = mana
	$Mana.max_value = max_mana

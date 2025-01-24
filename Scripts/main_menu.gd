extends CanvasLayer

@onready var startButton = $Background/Menu/Buttons/Start
@onready var optionsButton = $Background/Menu/Buttons/Options
@onready var exitButton = $Background/Menu/Buttons/Exit

func _ready() -> void:
	startButton.grab_focus()

func _on_start_pressed() -> void:
	GameManager.start_pressed()
	queue_free()

func _on_options_pressed() -> void:
	GameManager.options_pressed()
	queue_free()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_start_mouse_entered() -> void:
	startButton.grab_focus()

func _on_options_mouse_entered() -> void:
	optionsButton.grab_focus()

func _on_exit_mouse_entered() -> void:
	exitButton.grab_focus()

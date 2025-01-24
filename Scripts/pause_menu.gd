extends CanvasLayer

@onready var resumeButton: Button = $Background/Menu/Buttons/Resume
@onready var optionsButton: Button = $Background/Menu/Buttons/Options
@onready var exitButton: Button = $Background/Menu/Buttons/Exit

func _ready() -> void:
	resumeButton.grab_focus()

func _on_resume_pressed() -> void:
	GameManager.resume_pressed()
	queue_free()

func _on_options_pressed() -> void:
	GameManager.options_pressed()
	queue_free()

func _on_exit_pressed() -> void:
	GameManager.to_menu_pressed()
	queue_free()

func _on_resume_mouse_entered() -> void:
	resumeButton.grab_focus()

func _on_options_mouse_entered() -> void:
	optionsButton.grab_focus()

func _on_exit_mouse_entered() -> void:
	exitButton.grab_focus()

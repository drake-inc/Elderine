extends CanvasLayer

signal resume_pressed()
signal options_pressed()
signal to_menu_pressed()

func _ready() -> void:
	$Background/Menu/Buttons/Resume.grab_focus()

func _on_resume_pressed() -> void:
	resume_pressed.emit()

func _on_options_pressed() -> void:
	options_pressed.emit()

func _on_exit_pressed() -> void:
	to_menu_pressed.emit()

func _on_resume_mouse_entered() -> void:
	$Background/Menu/Buttons/Resume.grab_focus()

func _on_options_mouse_entered() -> void:
	$Background/Menu/Buttons/Options.grab_focus()

func _on_exit_mouse_entered() -> void:
	$Background/Menu/Buttons/Exit.grab_focus()

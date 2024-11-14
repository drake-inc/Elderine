extends Control

func _ready() -> void:
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")

func _on_start_mouse_entered() -> void:
	$VBoxContainer/Start.grab_focus()

func _on_option_pressed() -> void:
	pass # TODO add settings

func _on_options_mouse_entered() -> void:
	$VBoxContainer/Options.grab_focus()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_exit_mouse_entered() -> void:
	$VBoxContainer/Exit.grab_focus()

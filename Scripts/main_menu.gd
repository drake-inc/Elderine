extends Control

func _ready() -> void:
	$VBoxContainer2/Buttons/Start.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options_menu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_start_mouse_entered() -> void:
	$VBoxContainer2/Buttons/Start.grab_focus()

func _on_options_mouse_entered() -> void:
	$VBoxContainer2/Buttons/Options.grab_focus()

func _on_exit_mouse_entered() -> void:
	$VBoxContainer2/Buttons/Exit.grab_focus()

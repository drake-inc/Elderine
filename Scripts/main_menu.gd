extends Control

func _ready() -> void:
	$VBoxContainer/Start.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")


func _on_settings_pressed() -> void:
	pass # TODO add settings
 

func _on_exit_pressed() -> void:
	get_tree().quit()

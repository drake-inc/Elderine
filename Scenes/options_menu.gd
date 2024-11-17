extends Control

func _ready() -> void:
	$VBoxContainer/Settings/Buttons/Fullscreen.grab_focus()

func _on_fullscreen_ready() -> void:
	var fullscreen = $VBoxContainer/Settings/Buttons/Fullscreen
	var mode: int = max(get_window().mode - 2, 0)
	fullscreen.selected = mode

func _on_vsync_ready() -> void:
	var vsync = $VBoxContainer/Settings/Buttons/Vsync
	var mode: int = DisplayServer.window_get_vsync_mode()
	vsync.selected = mode

func _on_slider_ready() -> void:
	var slider = $VBoxContainer/Settings/Buttons/Volume/Slider
	var percent = $VBoxContainer/Settings/Buttons/Volume/Percent
	var current = slider.value
	percent.text = str(current) + "%"

func _on_fullscreen_item_selected(index: int) -> void:
	var fullscreen = $VBoxContainer/Settings/Buttons/Fullscreen
	var id = fullscreen.get_item_id(index)
	DisplayServer.window_set_mode(id)

func _on_vsync_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(index)

func _on_slider_value_changed(value: float) -> void:
	var percent = $VBoxContainer/Settings/Buttons/Volume/Percent
	percent.text = str(value) + "%"

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")



func _on_fullscreen_mouse_entered() -> void:
	$VBoxContainer/Settings/Buttons/Fullscreen.grab_focus()


func _on_vsync_mouse_entered() -> void:
	$VBoxContainer/Settings/Buttons/Vsync.grab_focus()


func _on_slider_mouse_entered() -> void:
	$VBoxContainer/Settings/Buttons/Volume/Slider.grab_focus()

func _on_back_mouse_entered() -> void:
	$VBoxContainer/Exit/Buttons/Back.grab_focus()

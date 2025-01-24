extends CanvasLayer

@onready var fullscreenButton: OptionButton = $Background/Menu/Settings/Buttons/Fullscreen
@onready var vsyncButton: OptionButton = $Background/Menu/Settings/Buttons/Vsync
@onready var volumeSlider: Slider = $Background/Menu/Settings/Buttons/Volume/Slider
@onready var volumePercent: Label = $Background/Menu/Settings/Buttons/Volume/Percent
@onready var backButton: Button = $Background/Menu/Exit/Buttons/Back

func _ready() -> void:
	var fullscreenMode: int = max(get_window().mode - 2, 0)
	fullscreenButton.selected = fullscreenMode
	
	var vsyncMode: int = DisplayServer.window_get_vsync_mode()
	vsyncButton.selected = vsyncMode
	
	var currentVolume = volumeSlider.value
	volumePercent.text = str(currentVolume) + "%"
	
	fullscreenButton.grab_focus()

func _on_back_pressed() -> void:
	GameManager.back_pressed()
	queue_free()

func _on_fullscreen_item_selected(index: int) -> void:
	var id = fullscreenButton.get_item_id(index)
	DisplayServer.window_set_mode(id)

func _on_vsync_item_selected(index: int) -> void:
	DisplayServer.window_set_vsync_mode(index)

func _on_slider_value_changed(value: float) -> void:
	volumePercent.text = str(value) + "%"

func _on_fullscreen_mouse_entered() -> void:
	fullscreenButton.grab_focus()

func _on_vsync_mouse_entered() -> void:
	vsyncButton.grab_focus()

func _on_slider_mouse_entered() -> void:
	volumeSlider.grab_focus()

func _on_back_mouse_entered() -> void:
	backButton.grab_focus()

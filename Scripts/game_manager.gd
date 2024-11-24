extends Node2D

enum Menu { MAIN, OPTIONS, PAUSE, GAME }

var current_menu = Menu.MAIN
var last_menu = Menu.MAIN
var level_index = 0

var main_menu: Node
var options_menu: Node
var pause_menu: Node
var game_menu: Node

func _ready() -> void:
	set_paused(true)
	set_enable(Menu.MAIN, true)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		match current_menu:
			Menu.OPTIONS:
				swap_menu(last_menu)
			Menu.PAUSE:
				print("a")
				set_paused(false)
				swap_menu(Menu.GAME)
			Menu.GAME:
				set_paused(true)
				swap_menu(Menu.PAUSE)
	elif event.is_action_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() >= 3:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	elif event.is_action_pressed("Test"):
		if level_index == 0:
			swap_level(1)
		else:
			swap_level(0)

# Enable new menu and disable the old one
func swap_menu(menu: Menu) -> void:
	last_menu = current_menu
	current_menu = menu
	set_enable(last_menu, false)
	set_enable(current_menu, true)

func swap_level(index: int) -> void:
	level_index = index
	if game_menu != null:
		game_menu.queue_free()
		game_menu = null
	set_enable(Menu.GAME, true)

# Enable or disable a given menu
func set_enable(menu: Menu, state: bool) -> void:
	match menu:
		Menu.MAIN:
			if state && main_menu == null:
				main_menu = load("res://Scenes/MainMenu.tscn").instantiate()
				main_menu.connect("options_pressed", _on_options_pressed)
				main_menu.connect("start_pressed", _on_start_pressed)
				add_child(main_menu)
			elif main_menu != null:
				main_menu.queue_free()
				main_menu = null
			if state && game_menu != null:
				game_menu.queue_free()
				game_menu = null
		Menu.OPTIONS:
			if state && options_menu == null:
				options_menu = load("res://Scenes/OptionsMenu.tscn").instantiate()
				options_menu.connect("back_pressed", _on_back_pressed)
				add_child(options_menu)
			elif options_menu != null:
				options_menu.queue_free()
				options_menu = null
		Menu.PAUSE:
			if state && pause_menu == null:
				pause_menu = load("res://Scenes/PauseMenu.tscn").instantiate()
				pause_menu.connect("options_pressed", _on_options_pressed)
				pause_menu.connect("to_menu_pressed", _on_to_menu_pressed)
				pause_menu.connect("resume_pressed", _on_resume_pressed)
				add_child(pause_menu)
			elif pause_menu != null:
				pause_menu.queue_free()
				pause_menu = null
		Menu.GAME:
			if state:
				if level_index == 0:
					game_menu = load("res://Scenes/Level.tscn").instantiate()
				else:
					game_menu = load("res://Scenes/Level1.tscn").instantiate()
				add_child(game_menu)

# Pause/unpause the game (excluding menus)
func set_paused(state: bool) -> void:
	get_tree().paused = state
	Engine.time_scale = !state

func _on_start_pressed() -> void:
	set_paused(false)
	swap_menu(Menu.GAME)

func _on_options_pressed() -> void:
	swap_menu(Menu.OPTIONS)

func _on_back_pressed() -> void:
	swap_menu(last_menu)
	
func _on_resume_pressed() -> void:
	set_paused(false)
	swap_menu(Menu.GAME)

func _on_to_menu_pressed() -> void:
	swap_menu(Menu.MAIN)

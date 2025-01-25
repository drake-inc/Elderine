extends Node2D

enum Menu { MAIN, OPTIONS, PAUSE, GAME }

var current_menu = Menu.MAIN
var last_menu = Menu.MAIN
var level_index = 0

var main_menu: Node
var options_menu: Node
var pause_menu: Node
var game_menu: Node

var player: Player

func _ready() -> void:
	set_paused(true)
	player = load("res://Scenes/Player.tscn").instantiate()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		match current_menu:
			Menu.OPTIONS:
				swap_menu(last_menu)
			Menu.PAUSE:
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

# Enable new menu and disable the old one
func swap_menu(menu: Menu) -> void:
	last_menu = current_menu
	current_menu = menu
	set_enable(last_menu, false)
	set_enable(current_menu, true)

func swap_level(index: int, spawn: Vector2) -> void:
	level_index = index
	
	# Create black loading screen
	var canvas_layer = CanvasLayer.new()
	var black_screen = ColorRect.new()
	canvas_layer.layer = 1000
	add_child(canvas_layer)
	canvas_layer.add_child(black_screen)
	black_screen.color = Color(0, 0, 0, 0)
	black_screen.anchor_right = 1
	black_screen.anchor_bottom = 1
	
	# Fade in the black screen
	var tween = create_tween()
	tween.tween_property(black_screen, "color:a", 1.0, 0.5)
	await tween.finished
	
	# Swap levels
	set_enable(Menu.GAME, false)
	await get_tree().process_frame
	set_enable(Menu.GAME, true)
	player.teleport_to(spawn)
	
	# Fade out the black screen
	tween = create_tween()
	tween.tween_property(black_screen, "color:a", 0.0, 0.5)
	await tween.finished
	
	canvas_layer.queue_free()

# Enable or disable a given menu
func set_enable(menu: Menu, state: bool) -> void:
	match menu:
		Menu.MAIN:
			if state && main_menu == null:
				main_menu = load("res://Scenes/MainMenu.tscn").instantiate()
				add_child(main_menu)
			elif main_menu != null:
				main_menu.queue_free()
				main_menu = null
			if state && game_menu != null:
				player.get_parent().remove_child(player)
				game_menu.queue_free()
				game_menu = null
		Menu.OPTIONS:
			if state && options_menu == null:
				options_menu = load("res://Scenes/OptionsMenu.tscn").instantiate()
				add_child(options_menu)
			elif options_menu != null:
				options_menu.queue_free()
				options_menu = null
		Menu.PAUSE:
			if state && pause_menu == null:
				pause_menu = load("res://Scenes/PauseMenu.tscn").instantiate()
				add_child(pause_menu)
			elif pause_menu != null:
				pause_menu.queue_free()
				pause_menu = null
		Menu.GAME:
			if state && game_menu == null:
				if level_index == 0:
					game_menu = load("res://Scenes/Level.tscn").instantiate()
				else:
					game_menu = load("res://Scenes/Level1.tscn").instantiate()
				add_child(game_menu)
				game_menu.add_child(player)
				print("Player parent after moving to new level:", player.get_parent())
			elif game_menu != null:
				player.get_parent().remove_child(player)
				game_menu.queue_free()
				game_menu = null

# Pause/unpause the game (excluding menus)
func set_paused(state: bool) -> void:
	get_tree().paused = state
	Engine.time_scale = !state

func start_pressed() -> void:
	set_paused(false)
	swap_menu(Menu.GAME)

func options_pressed() -> void:
	swap_menu(Menu.OPTIONS)

func back_pressed() -> void:
	swap_menu(last_menu)
	
func resume_pressed() -> void:
	set_paused(false)
	swap_menu(Menu.GAME)

func to_menu_pressed() -> void:
	swap_menu(Menu.MAIN)

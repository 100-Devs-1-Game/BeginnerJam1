extends Node


const TEST_LEVEL = preload("uid://clal44shu5gn")

@export var player: Player

var _player_in_start_area := true
var _start_location: Vector2i
var _continue_location: Vector2i
var _settings_location: Vector2i
var _quit_location: Vector2i

@onready var start_game_area: Area2D = %StartGameArea
@onready var continue_game_area: Area2D = %ContinueGameArea
@onready var settings_area: Area2D = %SettingsArea
@onready var quit_game_area: Area2D = %QuitGameArea
@onready var shadow_hider: Area2D = %ShadowHider
@onready var next_area_shadow: Sprite2D = %NextAreaShadow
@onready var start_button: Button = %StartButton
@onready var continue_button: Button = %ContinueButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton
@onready var player_start_area: Area2D = %PlayerStartArea
@onready var tile_map: TileMapLayer = $World/TileMapLayer
@onready var locked_menu_camera: Camera2D = %LockedMenuCamera
@onready var transition_camera: Camera2D = %TransitionCamera



func _ready() -> void:
	locked_menu_camera.make_current()
	start_game_area.area_entered.connect(_on_player_entered_start_game)
	continue_game_area.area_entered.connect(_on_player_entered_continue_game)
	settings_area.area_entered.connect(_on_player_entered_settings)
	quit_game_area.area_entered.connect(_on_player_entered_quit_game)
	shadow_hider.area_entered.connect(_on_player_made_menu_choice)
	next_area_shadow.show()
	start_button.pressed.connect(_on_start_button_pressed)
	start_button.mouse_entered.connect(_on_start_button_hovered)
	continue_button.pressed.connect(_on_continue_button_pressed)
	continue_button.mouse_entered.connect(_on_continue_button_hovered)
	settings_button.pressed.connect(_on_settings_button_pressed)
	settings_button.mouse_entered.connect(_on_settings_button_hovered)
	quit_button.pressed.connect(_on_quit_button_pressed)
	quit_button.mouse_entered.connect(_on_quit_button_hovered)
	player_start_area.area_entered.connect(_on_player_returned_to_start_area)
	player_start_area.area_exited.connect(_on_player_left_start_area)
	_start_location = tile_map.local_to_map($World/Start/Path/Start_1.global_position)
	_continue_location = tile_map.local_to_map($World/Continue/Path/Settings_1.global_position)
	_settings_location = tile_map.local_to_map($World/Settings/Path/Continue_1.global_position)
	_quit_location = tile_map.local_to_map($World/Quit/Path/Quit_1.global_position)

func _on_start_button_pressed() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _start_location:
		player.force_move_player(Vector2.RIGHT, 1)

func _on_start_button_hovered() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _start_location:
		return
	player.force_move_player(Vector2.UP, 1)

func _on_continue_button_pressed() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _continue_location:
		player.force_move_player(Vector2.RIGHT, 1)

func _on_continue_button_hovered() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _continue_location:
		return
	pass

func _on_settings_button_pressed() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _settings_location:
		player.force_move_player(Vector2.RIGHT, 1)

func _on_settings_button_hovered() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _settings_location:
		return
	pass

func _on_quit_button_pressed() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _quit_location:
		player.force_move_player(Vector2.RIGHT, 1)

func _on_quit_button_hovered() -> void:
	if not _player_in_start_area:
		return
	if player.grid_position == _quit_location:
		return
	player.force_move_player(Vector2.DOWN, 1)


func _on_player_returned_to_start_area(_a) -> void:
	_player_in_start_area = true
	create_tween().tween_property(next_area_shadow, "modulate", Color(1, 1, 1, 1.0), 0.5)
	_switch_camera(player.camera, locked_menu_camera)

func _on_player_left_start_area(_a) -> void:
	_player_in_start_area = false

func _on_player_entered_start_game(_a) -> void:
	get_tree().change_scene_to_packed.call_deferred(TEST_LEVEL)
	print("start_game")


func _on_player_entered_continue_game(_a) -> void:
	print("continue_game")


func _on_player_entered_settings(_a) -> void:
	print("settings")


func _on_player_entered_quit_game(_a) -> void:
	print("quit_game")
	get_tree().quit()

var _transition_time := 0.0
var _transitioning := false
var _from_camera: Camera2D
var _to_camera: Camera2D

func _process(delta: float) -> void:
	if _transitioning:
		_transition_time = clampf(_transition_time + delta, 0.0, 1.0)
		transition_camera.global_position = lerp(_from_camera.global_position, _to_camera.global_position, _transition_time)
		if _transition_time == 1.0:
			_transitioning = false
			_to_camera.make_current()


func _on_player_made_menu_choice(_a) -> void:
	if next_area_shadow.modulate == Color(0, 0, 0, 0):
		return
	create_tween().tween_property(next_area_shadow, "modulate", Color(0, 0, 0, 0), 0.5)
	_switch_camera(locked_menu_camera, player.camera)
	player.camera.enabled = true

func _switch_camera(from: Camera2D, to: Camera2D) -> void:
	_transitioning = true
	_transition_time = 0.0
	_from_camera = from
	_to_camera = to
	transition_camera.global_transform = _from_camera.global_transform
	transition_camera.make_current()

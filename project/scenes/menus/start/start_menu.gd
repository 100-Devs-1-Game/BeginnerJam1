extends Node

const TEST_LEVEL = preload("uid://clal44shu5gn")

@export var player: Player


#region class private variables
var _player_in_start_area := true
var _transition_time := 0.0
var _transitioning := false
var _from_camera: Camera2D
var _to_camera: Camera2D
var _exited_start_area_once := false
#endregion

#region onready variables
@onready var start_game_area: Area2D = %StartGameArea
@onready var continue_game_area: Area2D = %ContinueGameArea
@onready var settings_area: Area2D = %SettingsArea
@onready var quit_game_area: Area2D = %QuitGameArea
@onready var leaving_start_area: Area2D = %ShadowHider
@onready var next_area_shadow: Sprite2D = %NextAreaShadow
@onready var start_button: Button = %StartButton
@onready var continue_button: Button = %ContinueButton
@onready var settings_button: Button = %SettingsButton
@onready var quit_button: Button = %QuitButton
@onready var player_start_area: Area2D = %PlayerStartArea
@onready var tile_map: TileMapLayer = $World/TileMapLayer
@onready var locked_menu_camera: Camera2D = %LockedMenuCamera
@onready var transition_camera: Camera2D = %TransitionCamera
@onready var start_marker: Marker2D = %Start_Marker
@onready var continue_marker: Marker2D = %Continue_Marker
@onready var settings_marker: Marker2D = %Settings_Marker
@onready var quit_marker: Marker2D = %Quit_Marker
#endregion


func _ready() -> void:
	locked_menu_camera.make_current()
	next_area_shadow.show()
	
	# Handlers for the player made menu choice
	start_game_area.area_entered.connect(_on_player_entered_start_game)
	continue_game_area.area_entered.connect(_on_player_entered_continue_game)
	settings_area.area_entered.connect(_on_player_entered_settings)
	quit_game_area.area_entered.connect(_on_player_entered_quit_game)
	
	# Handlers for the invisible buttons to support mouse
	start_button.pressed.connect(_on_main_menu_button_pressed)
	start_button.mouse_entered.connect(_on_main_menu_button_hovered.bind(start_marker.global_position))
	continue_button.pressed.connect(_on_main_menu_button_pressed)
	continue_button.mouse_entered.connect(_on_main_menu_button_hovered.bind(continue_marker.global_position))
	settings_button.pressed.connect(_on_main_menu_button_pressed)
	settings_button.mouse_entered.connect(_on_main_menu_button_hovered.bind(settings_marker.global_position))
	quit_button.pressed.connect(_on_main_menu_button_pressed)
	quit_button.mouse_entered.connect(_on_main_menu_button_hovered.bind(quit_marker.global_position))

	# Handers for knowing where the player is 
	leaving_start_area.area_entered.connect(_on_player_leaving_start_area)
	player_start_area.area_entered.connect(_on_player_returned_to_start_area)
	player_start_area.area_exited.connect(_on_player_left_start_area)


#region virtual methods
func _process(delta: float) -> void:
	if _transitioning:
		_transition_time = clampf(_transition_time + delta, 0.0, 1.0)
		transition_camera.global_position = lerp(_from_camera.global_position, _to_camera.global_position, _transition_time)
		if _transition_time == 1.0:
			_transitioning = false
			_to_camera.make_current()
#endregion


#region class handlers
func _on_main_menu_button_pressed() -> void:
	if _player_in_start_area:
		player.force_move_player(Vector2.RIGHT, 1)


func _on_main_menu_button_hovered(marker_global_position: Vector2) -> void:
	if _player_in_start_area:
		player.teleport_player(marker_global_position)


func _on_player_returned_to_start_area(_a) -> void:
	if _exited_start_area_once:
		_player_in_start_area = true
		create_tween().tween_property(next_area_shadow, "modulate", Color(1, 1, 1, 1.0), 0.5)
		_switch_camera(player.camera, locked_menu_camera)


func _on_player_left_start_area(_a) -> void:
	_player_in_start_area = false


func _on_player_entered_start_game(_a) -> void:
	get_tree().change_scene_to_packed.call_deferred(TEST_LEVEL)


func _on_player_entered_continue_game(_a) -> void:
	print("continue_game")


func _on_player_entered_settings(_a) -> void:
	print("settings")


func _on_player_entered_quit_game(_a) -> void:
	get_tree().quit()


func _on_player_leaving_start_area(_a) -> void:
	if next_area_shadow.modulate == Color(0, 0, 0, 0):
		return
	_exited_start_area_once = true
	create_tween().tween_property(next_area_shadow, "modulate", Color(0, 0, 0, 0), 0.5)
	_switch_camera(locked_menu_camera, player.camera)
	player.camera.enabled = true
#endregion


#region class private methods
func _switch_camera(from: Camera2D, to: Camera2D) -> void:
	_transitioning = true
	_transition_time = 0.0
	_from_camera = from
	_to_camera = to
	transition_camera.global_transform = _from_camera.global_transform
	transition_camera.make_current()

#endregion

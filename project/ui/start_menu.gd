extends Node


const TEST_LEVEL = preload("uid://clal44shu5gn")


@onready var start_game_area: Area2D = %StartGameArea
@onready var continue_game_area: Area2D = %ContinueGameArea
@onready var settings_area: Area2D = %SettingsArea
@onready var quit_game_area: Area2D = %QuitGameArea


func _ready() -> void:
	start_game_area.area_entered.connect(_on_player_entered_start_game)
	continue_game_area.area_entered.connect(_on_player_entered_continue_game)
	settings_area.area_entered.connect(_on_player_entered_settings)
	quit_game_area.area_entered.connect(_on_player_entered_quit_game)


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

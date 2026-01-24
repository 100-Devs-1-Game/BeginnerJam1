class_name Player
extends Node2D

#region signals
signal moved_ended_at(location: Vector2i)
#endregion

#region constants
const GRID_SIZE := 32  # TODO Move to a global defined constant
const TURN_DURATION := 0.1  # TODO Move to a global defined constant
#endregion

#region class variables
var grid_position := Vector2i.ZERO
#endregion

#region private variables
var _is_moving := false
var _ended_on_ice := false
var _last_requested_movement_direction := Vector2.ZERO
#endregion

#region onready variables
@onready var visuals: Node2D = %Visuals
@onready var shadow_sprite: Sprite2D = %ShadowSprite
@onready var character_sprite: AnimatedSprite2D = %AnimatedCharacterSprite
@onready var area: Area2D = %Area2D
@onready var camera: Camera2D = %PlayerCamera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# TODO Temporary Tilemap direct access
@onready var dungeon_tile_map: TileMapLayer


#endregion


#region virtual methods
func _ready() -> void:
	grid_position = (global_position / GRID_SIZE) as Vector2i
	area.area_entered.connect(_on_area_entered)
	dungeon_tile_map = get_parent().get_node("TileMapLayer")
	assert(dungeon_tile_map is TileMapLayer)


func _process(_delta: float) -> void:
	move_character()


func move_character() -> void:
	if _is_moving:
		return
	var desired_movement: Vector2
	if _ended_on_ice:
		desired_movement = _last_requested_movement_direction
	else:
		desired_movement = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if desired_movement.x != 0.0 and desired_movement.y != 0.0:
			return  # Rejects input if tryint to move diagonally
		if desired_movement == Vector2.ZERO:
			return
	if desired_movement.x:
		character_sprite.flip_h = desired_movement.x < 0
	_last_requested_movement_direction = desired_movement
	var desired_location: Vector2i = grid_position + (desired_movement as Vector2i)
	var tile_data: TileData
	tile_data = dungeon_tile_map.get_cell_tile_data(desired_location)
	if tile_data and tile_data.get_custom_data("WALL"):
		if _ended_on_ice:
			_ended_on_ice = false
			return
		else:
			# TODO bounce effect
			return
	# TODO Initiate Turn
	_is_moving = true
	grid_position += desired_movement as Vector2i
	_ended_on_ice = tile_data and tile_data.get_custom_data("ICE")
	  # global_position + desired_movement * GRID_SIZE
	var desired_global_pos: Vector2 = dungeon_tile_map.map_to_local(dungeon_tile_map.local_to_map(global_position) + (desired_movement as Vector2i))
	character_sprite.play("walking")
	var tween := create_tween()
	tween.tween_property(self, "global_position", desired_global_pos, TURN_DURATION).set_ease(Tween.EASE_IN)
	tween.tween_callback(moved_ended_at.emit.bind(grid_position))
	tween.tween_callback(character_sprite.play.bind("default"))
	tween.tween_callback(func(): _is_moving = false)  # TODO do in response to turnmanager instead

#endregion


#region class handlers

func _on_area_entered(other_area: Area2D) -> void:
	print("Encountered other area: %s" % other_area)

#endregion


#region class methods


#endregion

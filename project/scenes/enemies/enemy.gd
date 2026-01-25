class_name Enemy
extends Node2D

@export var patrol_path_node: Path2D
@export var target_tilemap: TileMapLayer

#region constants
const TURN_DURATION := 0.5 # TODO Move to a global defined constant
#endregion

#region private variables
var _patrol_path_global: Array[Vector2]
var _current_patrol_path_index: int = 0
#endregion

#region onready variables
@onready var _animated_sprite: AnimatedSprite2D = %AnimatedEnemySprite
#endregion

func _ready() -> void:
	setup_patrol_path_global()

	if not _patrol_path_global.is_empty():
		self.global_position = snap_global_to_tile_center(_patrol_path_global[0])
		patrol()

func setup_patrol_path_global() -> void:
	if not patrol_path_node or not patrol_path_node.curve or not target_tilemap:
		return
	
	var curve: Curve2D = patrol_path_node.curve
	_patrol_path_global.clear()
	for i in range(curve.point_count):
		_patrol_path_global.append(patrol_path_node.to_global(curve.get_point_position(i)))

func patrol() -> void:
	if _patrol_path_global.size() < 2:
		return

	while is_inside_tree():
		# Advance to next, but start from the start if there are no more points
		_current_patrol_path_index = (_current_patrol_path_index + 1) % _patrol_path_global.size()
		await move_to_snapped_global_pos(_patrol_path_global[_current_patrol_path_index])

func move_to_snapped_global_pos(target_global_pos: Vector2) -> void:
	var snapped_target_global_pos : Vector2 = snap_global_to_tile_center(target_global_pos)
	
	if (snapped_target_global_pos - self.global_position).x != 0:
		_animated_sprite.flip_h = (snapped_target_global_pos - self.global_position).x < 0

	_animated_sprite.play("walking")
	var tween : Tween = create_tween()
	tween.tween_property(self, "global_position", snapped_target_global_pos, TURN_DURATION)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	
	await tween.finished
	_animated_sprite.play("default")

func snap_global_to_tile_center(global_pos: Vector2) -> Vector2:
	var grid_pos: Vector2i = target_tilemap.local_to_map(target_tilemap.to_local(global_pos))
	return target_tilemap.to_global(target_tilemap.map_to_local(grid_pos))

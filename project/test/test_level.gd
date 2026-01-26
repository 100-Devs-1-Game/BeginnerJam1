class_name TestLevel
extends Level


## Test Level script extending from base Level script
## can be used to test certain features in the Test Scene
## while the base Level class should contain feature that are common to all Levels

#region constants

# feel free to change those to do your own tests
const TEST_MAP_CONVERSION := true
const TEST_TILE_DATA := true
const TILE_DATA_STRING := "test_data"

#endregion

#region virtual methods

func _ready() -> void:
	super()

func _process(delta: float) -> void:
	super(delta)
	if TEST_MAP_CONVERSION:
		_test_map_conversion()
	if TEST_TILE_DATA and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_test_tile_data(TILE_DATA_STRING)
	
#endregion

#region class methods

## Prints the mouse global position and its corresponding grid position
func _test_map_conversion() -> void:
	var mouse_pos := get_global_mouse_position()
	var grid_pos := Map.global_to_map(mouse_pos)
	var global_pos := Map.map_to_global(grid_pos)
	
	prints("Mouse position", mouse_pos, "-> Grid position", grid_pos, "-> Global position", global_pos)


## Prints the value of the custom data [param data_name] at the mouse's position
func _test_tile_data(data_name : String = "") -> void:
	var mouse_pos := get_global_mouse_position()
	var grid_pos := Map.global_to_map(mouse_pos)
	var custom_data : Variant = Map.get_custom_data(grid_pos, data_name)
	
	prints("Grid position", grid_pos, "->", data_name, "=", custom_data)

#endregion

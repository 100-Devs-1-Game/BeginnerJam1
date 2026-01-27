extends Node
@onready var music: AudioStreamPlayer = $Music
@onready var sfx_1: AudioStreamPlayer = $SFX1



func _ready() -> void:
	music.play()

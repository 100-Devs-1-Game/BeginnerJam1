class_name Key
extends Node2D

@export var doorway: Node2D

@onready var area: Area2D = $Area2D

func _ready() -> void:
	Signalbus.grabbed_key.connect(stuffdonewhenkeygrabbed)
	area.area_entered.connect(_on_key_picked_up)

func _on_tree_entered() -> void: #if we instantiate this later
	Signalbus.connect("grabbed_key", stuffdonewhenkeygrabbed)
	print("connected grabbed key signal")
	#Signalbus.grabbed_key.connect(stuffdonewhenkeygrabbed) <- same thing
	pass
	
func _on_tree_exit() -> void:
	Signalbus.grabbed_key.disconnect(stuffdonewhenkeygrabbed)
	print("disconnected grabbed key signal")
	pass

func _on_key_picked_up(_other_area: Area2D) -> void:
	# TODO Simplified solution implemented only for the purposes of the Start Menu
	doorway.hide()
	print("Key picked up!")
	Signalbus.grabbed_key.emit()
	Signalbus.keysgrabbed +=1
	queue_free()
func stuffdonewhenkeygrabbed():
	print ("something else happened")

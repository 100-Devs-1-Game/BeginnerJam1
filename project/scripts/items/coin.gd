class_name Coin extends Area2D

func collect() -> void:
	Events.coin_collected.emit()
	call_deferred("queue_free")

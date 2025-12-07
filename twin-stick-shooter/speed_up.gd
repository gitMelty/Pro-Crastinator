extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("powerups")
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_tree_entered() -> void:
	add_to_group("powerups")
	await get_tree().create_timer(13).timeout
	queue_free()

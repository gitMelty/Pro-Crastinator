extends Area2D

var speed = 750

var direction = global_transform.basis_xform(Vector2.ZERO)

func _physics_process(delta):
	global_position -= transform.x * speed * delta
	



# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		body.queue_free()
	

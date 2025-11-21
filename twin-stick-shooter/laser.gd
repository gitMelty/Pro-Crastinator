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
	


func _on_body_entered(body: RigidBody2D) -> void: #remove laser when it hits an enemy
	body.queue_free()
	queue_free()



func _on_visible_on_screen_notifier_2d_screen_exited() -> void: #remove laser when it exits screen
	queue_free()

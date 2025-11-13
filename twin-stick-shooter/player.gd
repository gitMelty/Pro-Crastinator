extends CharacterBody2D
var screen_size

@export var speed = 400
var pos = get_local_mouse_position() - position

func start():
	position = pos
	show()
	$CollisionShape2D.disabled = false


func get_input(): #8-way movement with WASD
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
func _physics_process(_delta): 
	get_input()
	move_and_slide()
	get_rotate()

func get_rotate(): #rotation looking at mouse, can be changed to a more mobile friendly version if anyone knows how
	rotation = get_global_mouse_position().angle_to_point(position)
	velocity = transform.x * Input.get_axis("rotate_down", "rotate_up") * speed

signal hit


func  _on_area_2d_body_entered(_body: RigidBody2D) -> void:
	#hiding the player and emitting hit signal when colliding with mobs
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

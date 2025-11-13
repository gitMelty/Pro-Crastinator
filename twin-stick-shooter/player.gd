extends CharacterBody2D

@export var speed = 400
var pos = get_local_mouse_position() - position


func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	
func _physics_process(_delta):
	get_input()
	move_and_slide()
	get_rotate()

func get_rotate():
	rotation = get_global_mouse_position().angle_to_point(position)
	velocity = transform.x * Input.get_axis("rotate_down", "rotate_up") * speed

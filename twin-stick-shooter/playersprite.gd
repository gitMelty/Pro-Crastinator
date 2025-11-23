extends CharacterBody2D
var pos = get_local_mouse_position() - position

# Called when the node enters the scene tree for the first time.
func start() -> void:
	position = pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_process(_delta):
	get_rotated()
	get_global_mouse_position().angle_to_point

func get_rotated():
	pos = get_global_mouse_position().angle_to_point(position)
	if get_global_mouse_position().x > global_position.x: #&& $AnimatedSprite2D.is_flipped_h() == false:
		$AnimatedSprite2D.flip_h = true
	elif get_global_mouse_position().x < global_position.x: #&& $AnimatedSprite2D.is_flipped_h() == true:
		$AnimatedSprite2D.flip_h = false

#if you see this forget about this for now, I'm trying to make this work -Siiri

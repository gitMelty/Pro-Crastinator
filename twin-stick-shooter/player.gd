extends CharacterBody2D
var screen_size

var laser_scene = preload("res://laser.tscn")
signal laser_shot(laser_scene, location)

@onready var muzzle = $Muzzle

@export var speed = 400
var pos = get_local_mouse_position() - position

func start():
	position = pos
	$CollisionShape2D.disabled = false

func shoot():
	laser_shot.emit(laser_scene,muzzle.global_position)
	#owner.add_child(l)
	#l.transform = $Muzzle.global_transform

func get_input(): #8-way movement with WASD
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * speed
	

func _process(delta): #called every frame
	if Input.is_action_just_pressed("shoot"): #shoot action
		shoot()
	get_input()


func _physics_process(_delta): #physics process called every frame
	move_and_slide()
	get_rotate()

func get_rotate(): #rotation looking at mouse, can be changed to a more mobile friendly version if anyone knows how
	rotation = get_global_mouse_position().angle_to_point(position)
	velocity = transform.x * Input.get_axis("rotate_down", "rotate_up") * speed
	#Flip
	#if get_global_mouse_position().y > position.y: #&& $AnimatedSprite2D.is_flipped_h() == false:
		#$AnimatedSprite2D.animation = "flipped"
	
	#elif get_global_mouse_position().y < position.y: #&& $AnimatedSprite2D.is_flipped_h() == true:
		#$AnimatedSprite2D.animation = "walk"
		
	

signal hit


func  _on_area_2d_body_entered(_body: RigidBody2D) -> void:
	#hiding the player and emitting hit signal when colliding with mobs
	hide()
	hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)


func _on_area_2d_area_entered(_body: RigidBody2D) -> void:
	$Player.hide()
	hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)

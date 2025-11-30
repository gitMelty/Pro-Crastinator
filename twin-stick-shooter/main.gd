extends Node

#@export var speed_up_scene: Node
@export var mob_scene: PackedScene
@export var laser_scene: Node
@onready var laser_container = $LaserContainer
@onready var powerup_container = $PowerupContainer
var speed_up_scene = preload("res://speed_up.tscn")

var player = null
var score
var isSpeed = false
var gameActive = false

func _ready():
	$Player.hide()
	$Music.play()
	$GameTimer.start()

func _process(delta):
	#playersprite()
	pass

var startpos = Vector2(960, 540)

#func playersprite():
	#$playersprite.global_position = $Player.global_position
	

func shoot():
	Input.action_press("shoot")

func new_game(): #called when pressing "start game" button
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")
	$Player.show()
	$Player.global_position = startpos
	$HUD.show_message("Get Ready")
	score = 0
	$HUD.update_score(score)
	$HUD.hide_logo()
	$StartTimer.start()
	isSpeed = false
	$SpeedTimer.start()
	$PowerupTimer.start()
	gameActive = true

func _on_start_timer_timeout():
	$MobTimer.start()


func _on_mob_timer_timeout() -> void: #mob spawn function, called every time mob timer times out
	var mob = mob_scene.instantiate()
	
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	#mob.rotation = direction
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	if isSpeed:
		velocity += Vector2(randf_range(300, 450), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	if gameActive:
		laser_container.owner.add_child(laser)
	laser.global_position = location
	laser.transform = $Player/Muzzle.global_transform

func _on_child_exiting_tree(_body: RigidBody2D) -> void: #add score when mob exits main scene tree
	score += 10
	if gameActive:
		$HUD.update_score(score)

func game_over() -> void: #call function when player loses
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("powerups", "queue_free")
	$HUD.show_logo()
	$PowerupTimer.stop()
	gameActive = false

func _on_speed_timer_timeout() -> void: #function if mobs become faster
	isSpeed = true


func _on_game_timer_timeout() -> void:
	get_tree().quit()


func _on_powerup_timer_timeout() -> void:
	await get_tree().create_timer(randf_range(10,25)).timeout
	
	var powerup = speed_up_scene.instantiate()
	if gameActive:
		powerup_container.owner.add_child(powerup)
	
	var powerup_spawn_location = $PowerupPath/PowerupSpawnLocation
	powerup_spawn_location.progress_ratio = randf()
	
	powerup.position = powerup_spawn_location.position
	
	await get_tree().create_timer(15).timeout
	
	$PowerupTimer.start()



func _on_player_getspeed() -> void:
	get_tree().call_group("powerups", "queue_free")

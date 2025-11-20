extends Node

@export var mob_scene: PackedScene
@export var laser_scene: Node
@onready var laser_container = $LaserContainer

var player = null
var score

func _ready():
	$Player.hide()
	$Music.play()


var startpos = Vector2(960, 540)

func shoot():
	Input.action_press("shoot")

func new_game():
	$HUD.update_score(score)
	get_tree().call_group("mobs", "queue_free")
	$Player.show()
	$Player.global_position = startpos
	$HUD.show_message("Get Ready")
	score = 0
	$HUD.update_score(score)
	$HUD.hide_logo()
	$StartTimer.start()
	

func _on_start_timer_timeout():
	$MobTimer.start()


func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	#mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser_container.owner.add_child(laser)
	laser.global_position = location
	laser.transform = $Player/Muzzle.global_transform

func _on_child_exiting_tree(_body: RigidBody2D) -> void:
	score += 1
	$HUD.update_score(score)

func game_over() -> void:
	$MobTimer.stop()
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$HUD.show_logo()

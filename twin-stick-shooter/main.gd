extends Node

@export var mob_scene: PackedScene
@export var laser_scene: Node
@onready var laser_container = $LaserContainer

var player = null

func _ready():
	new_game()
	player = get_tree().get_first_node_in_group("Player")
	

func shoot():
	Input.action_press("shoot")

func new_game():
	#$Node2D.start($StartPosition.position)
	$StartTimer.start()
	get_tree().call_group("mobs", "queue_free")

func _on_start_timer_timeout():
	$MobTimer.start()

func _on_mob_timer_timeout() -> void:
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	mob.position = mob_spawn_location.position
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)

func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser_container.owner.add_child(laser)
	laser.global_position = location
	laser.transform = $Player/Muzzle.global_transform

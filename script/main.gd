extends Node2D


@onready var obstacles = $Obstacles
@onready var circle_path = $CirclePath
@onready var retry = $retry
@onready var animation_player = $score/AnimationPlayer
@onready var label_2 = $Label2
@onready var enemy_spawner = $EnemySpawner


func _ready():
	BgmManager.play_audio("game")


func add_obstacle(obstacle, p_global_position):
	obstacles.add_child(obstacle)
	obstacle.global_position = p_global_position


func _on_base_destroyed():
	enemy_spawner.player_is_dead = true
	circle_path.player_is_dead = true
	circle_path.player.player_is_dead = true
	animation_player.play("score")
	await animation_player.animation_finished
	retry.show()
	label_2.show()

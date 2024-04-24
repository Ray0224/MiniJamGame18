extends Node2D
var player_is_dead : bool
var point : int
@export var spawn_time := 1.0

@onready var enemy_scene: PackedScene = preload("res://scene/enemy.tscn")
@onready var enemies = $Enemies
@onready var path_follow = $EnemySpawnPath/PathFollow as PathFollow2D
@onready var label = $"../Label"
@onready var label_2 = $"../Label2"


func spawn_enemy():
	if player_is_dead == true:
		return
	path_follow.progress_ratio = randf_range(0.0, 1.0)
	
	var enemy = enemy_scene.instantiate()
	enemies.add_child(enemy)
	enemy.position = path_follow.position
	enemy.dead_sig.connect(Callable(self, "add_point"))
	
	var home_base = get_tree().get_first_node_in_group("Base")
	enemy.move_direction = (home_base.global_position - enemy.global_position).normalized()

func add_point():
	if player_is_dead == false:
		point += 1
		update_point()
func update_point():
	label.text = str(point)
	label_2.text = str(point)

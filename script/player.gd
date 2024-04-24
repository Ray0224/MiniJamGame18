extends Area2D


signal obstacle_generated(obstacle, position)

var obstacle_scene: PackedScene = preload("res://scene/obstacle.tscn")
var ink_remain := 100.0
var ink_use_speed := 200.0
var filling_ink = true
var current_trail
var player_is_dead : bool


@onready var progress_bar = $ProgressBar
@onready var trail = preload("res://Ray/scene/trail.tscn")
@onready var node = $Node
@onready var fill_sound = $FillSound


func _ready():
	var ins = trail.instantiate()
	current_trail = ins
	node.add_child(ins)

func _physics_process(delta):
	if player_is_dead == true:
		return
	if ink_remain > 0:
		generate()
		current_trail.add(global_position)
		
	else:
		if current_trail.first_point == true:
			var ins = trail.instantiate()
			current_trail = ins
			node.add_child(ins)
		
	if filling_ink:
		if ink_remain < 100:
			play_fill_sound()
		ink_remain = 100
	else:
		ink_remain -= ink_use_speed * delta
		ink_remain = max(0.0, ink_remain)
	progress_bar.value = ink_remain

	
func generate():
	var obstacle = obstacle_scene.instantiate()
	obstacle_generated.emit(obstacle, global_position)
	obstacle.is_free.connect(Callable(current_trail, "remove"))

func fill_ink(flag):
	filling_ink = flag


func play_fill_sound():
	fill_sound.play()

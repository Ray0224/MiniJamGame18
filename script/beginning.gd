extends Node2D
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("beginning")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	SceneTran.scene_tran("res://scene/startScene.tscn")

func trans_to_start():
	get_tree().change_scene_to_file("res://scene/startScene.tscn")

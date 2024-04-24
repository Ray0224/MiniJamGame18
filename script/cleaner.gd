extends Node2D


@onready var animation_player = $AnimationPlayer


func play_extend():
	animation_player.play("cleaner")
	
	
func play_shrink():
	animation_player.play_backwards("cleaner")

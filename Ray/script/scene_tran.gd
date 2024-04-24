extends Node2D
@onready var ani_player = $AnimationPlayer


		
func scene_tran(file):
	ani_player.play("test")
	await ani_player.animation_finished
	get_tree().change_scene_to_file(file)
	ani_player.play_backwards("test")
func reload():
	ani_player.play("test")
	await ani_player.animation_finished
	get_tree().reload_current_scene()
	ani_player.play_backwards("test")

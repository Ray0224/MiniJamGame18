extends Node


@onready var die_sounds: Array = $DieSounds.get_children()
@onready var hurt_sound = $HurtSound


func play_die_sound():
	var die_sound_player: AudioStreamPlayer = die_sounds.pick_random()
	die_sound_player.play()


func play_hurt_sound():
	hurt_sound.play()

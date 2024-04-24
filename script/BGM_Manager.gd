extends Node


var changing := false
var next_audio

@onready var game_theme = preload("res://asset/music/main_theme.wav")
@onready var bgm_player = $BGMPlayer


func play_audio(target: String):
	next_audio = target
	if changing:
		return
	
	if bgm_player.playing:
		changing = true
		var tween = create_tween()
		tween.tween_property(bgm_player, "volume_db", -80, 0.5)
		await tween.finished
		bgm_player.stop()
		
	if next_audio == "game":
		bgm_player.stream = game_theme
		bgm_player.volume_db = -5
		
	bgm_player.play()
	changing = false

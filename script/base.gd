extends Area2D
@onready var heart = $"../hearts/heart"
@onready var heart_2 = $"../hearts/heart2"
@onready var heart_3 = $"../hearts/heart3"
@onready var heart_4 = $"../hearts/heart4"
@onready var heart_5 = $"../hearts/heart5"


signal destroyed()

var health = 5
var hearts = []

func _ready():
	hearts.append(heart)
	hearts.append(heart_2)
	hearts.append(heart_3)
	hearts.append(heart_4)
	hearts.append(heart_5)

func on_hit(enemy):
	health -= 1
	AudioManager.play_hurt_sound()
	if health < 0:
		return
	if hearts[health] == null:
		return
	hearts[health].dead()
	
	enemy.queue_free()
	if health == 0:
		destroyed.emit()
#func _process(delta):
	#if Input.is_action_just_pressed("LeftClick"):
		#destroyed.emit()

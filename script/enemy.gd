extends Area2D

signal dead_sig()
@export var move_speed := 100.0
@export var melt_rate : float

var is_dead : bool
var melt = -1
var move_direction := Vector2.LEFT
var first_hit = false

@onready var virus_01 = $virus/Virus01
@onready var virus_02 = $virus/Virus02
@onready var animation_player = $virus/AnimationPlayer


func _ready():
	animation_player.play("move")


func on_hit():
	if first_hit:
		return

	first_hit = true
	dead_sig.emit()
	if not is_dead:
		AudioManager.play_die_sound()
		animation_player.play("death")
		
	
func _process(delta):
	if is_dead:
		melt += melt_rate*delta
		virus_01.material.set_shader_parameter("melt",melt)
		virus_02.material.set_shader_parameter("melt",melt)
		if melt > 1:
			queue_free()
	elif not first_hit:
		position += move_direction * move_speed * delta


func dead():
	is_dead = true
	animation_player.play("disappear")


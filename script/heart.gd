extends Node2D
@onready var animation_player = $AnimationPlayer
@export var melt_rate : float
var is_dead : bool
var melt = -1
@onready var heart = $Heart

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("heart")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead:
		melt += melt_rate*delta
		heart.material.set_shader_parameter("melt",melt)
		if melt > 1:
			queue_free()
func dead():
	is_dead = true
	animation_player.play("disappear")

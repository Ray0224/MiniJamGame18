extends Node2D


@export var num_points := 40
@export var min_radius := 100.0
@export var max_radius := 300.0
@export var min_move_speed := 0.5 * PI
@export var max_move_speed := 2 * PI
@export var speed_change_step := 21.6

var speed: float
var radius: float
var speeding_up := false
var slowing_down := false

@onready var line_2d = $Line2D
@onready var center_pivot = $CenterPivot
@onready var player = $CenterPivot/Player
@onready var high_brush_sound = preload("res://asset/SFX/brush_out.wav")
@onready var low_brush_sound = preload("res://asset/SFX/brush_in.wav")
@onready var loop_brush_sound = preload("res://asset/SFX/loop_brush_sound.wav")
@onready var brush_sonud_player = $BrushSonudPlayer
@onready var cleaner = $CenterPivot/cleaner
var player_is_dead : bool

func _ready():
	radius = min_radius
	speed = min_move_speed
	draw_circle_line()
	player.position = Vector2.RIGHT * radius


func draw_circle_line():
	line_2d.clear_points()
	
	var point_position := Vector2.RIGHT * radius
	var rad_step = 2 * PI / num_points
	for i in num_points + 1:
		line_2d.add_point(point_position)
		point_position = point_position.rotated(rad_step)


func _process(delta):
	if  player_is_dead == true:
		return
	if Input.is_action_pressed("Space"):
		speed_up(delta)
		slowing_down = false
	elif speed != min_move_speed:
		slow_down(delta)
		speeding_up = false
	else:
		speeding_up = false
		slowing_down = false
#		if brush_sonud_player.stream != loop_brush_sound:
#			brush_sonud_player.stream = loop_brush_sound
#			brush_sonud_player.play()
			
	center_pivot.rotation += speed * delta
	
	if speed == min_move_speed:
		player.fill_ink(true)
	else:
		player.fill_ink(false)
	
	if speed == max_move_speed:
		get_tree().call_group("Barrier", "activate")
	else:
		get_tree().call_group("Barrier", "deactivate")
	

func speed_up(delta):
	speed += speed_change_step * delta
	speed = clampf(speed, min_move_speed, max_move_speed)
	radius = lerp(min_radius, max_radius, (speed - min_move_speed) / (max_move_speed - min_move_speed))
	draw_circle_line()
	player.position = Vector2.RIGHT * radius
	
	if not speeding_up:
		speeding_up = true
		cleaner.play_extend()
		if player.ink_remain > 0:
			brush_sonud_player.stream = high_brush_sound
			brush_sonud_player.bus = "BrushSound"
			brush_sonud_player.play()
		

func slow_down(delta):
	speed -= speed_change_step * delta
	speed = clampf(speed, min_move_speed, max_move_speed)
	radius = lerp(min_radius, max_radius, (speed - min_move_speed) / (max_move_speed - min_move_speed))
	draw_circle_line()
	player.position = Vector2.RIGHT * radius
	
	if not slowing_down:
		slowing_down = true
		cleaner.play_shrink()
		if player.ink_remain > 0:
			brush_sonud_player.stream = low_brush_sound
			brush_sonud_player.bus = "BrushSound"
			brush_sonud_player.play()

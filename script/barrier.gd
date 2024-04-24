extends Area2D


signal exploded

@export var explode_time := 0.5
@export var num_points := 40

var health: int = 10
var exploding := false
var radius := 80.0
var broken := false

@onready var collision_shape_2d = $CollisionShape2D
@onready var line_2d = $Line2D
@onready var fix_timer = $FixTimer


func _ready():
	collision_shape_2d.shape.radius = radius
	draw_circle_line()
	

func deactivate():
	monitoring = false


func activate():
	monitoring = true


func draw_circle_line():
	line_2d.clear_points()
	
	var point_position := Vector2.UP * radius
	var rad_step = 2 * PI / num_points
	for i in num_points + 1:
		line_2d.add_point(point_position)
		point_position = point_position.rotated(rad_step)


func on_hit(enemy):
	if broken:
		return
	
	enemy.queue_free()
	
	if health > 0:
		for i in line_2d.get_point_count() / health:
			line_2d.remove_point(line_2d.get_point_count() - 1)
		health -= 1
	
	if health == 0 and !exploding:
		exploding = true
		var tween = create_tween()
		tween.tween_property(collision_shape_2d.shape, "radius", 300, explode_time)
		await tween.finished
		collision_shape_2d.shape.radius = radius
		fix_timer.start()
		broken = true


func _on_fix_timer_timeout():
	if line_2d.get_point_count() == 0:
		line_2d.add_point(Vector2.UP * radius)
	elif line_2d.get_point_count() < num_points + 1:
		line_2d.add_point(line_2d.get_point_position(line_2d.get_point_count() - 1).rotated(2 * PI / num_points))
		
		if line_2d.get_point_count() == num_points + 1:
			fix_timer.stop()
			broken = false
			
		

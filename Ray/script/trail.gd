extends Line2D
@export var first_point : bool



# Called every frame. 'delta' is the elapsed time since the previous frame.

func add(point):

	if first_point == false :
		first_point = true
	add_point(point)	
func remove():
	if get_point_count() > 0:
		remove_point(0)
	if get_point_count() == 1:
		queue_free()



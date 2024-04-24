extends Area2D


signal is_free()


func on_hit(enemy):
	enemy.on_hit()

	
func _on_free_timer_timeout():
	queue_free()
	is_free.emit()


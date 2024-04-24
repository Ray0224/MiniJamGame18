extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		SceneTran.scene_tran("res://Ray/scene/shader_test.tscn")





func _on_button_button_up():
	SceneTran.reload()

extends Control

func _ready():
	pass
	
func _physics_process(delta):
	if Input.is_action_just_released("interact"):
		print('pressed')
		get_tree().change_scene('res://game.tscn')

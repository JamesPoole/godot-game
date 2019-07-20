extends KinematicBody2D

const MOVE = Vector2(20, 0)
const UP = Vector2(0, 1)

func _ready():
	pass
	
func _process(delta):
	move_and_slide(MOVE, UP)
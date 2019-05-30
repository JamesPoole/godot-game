extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCEL = 40
const MAX_SPEED = 125
const JUMP_HEIGHT = -200

var motion = Vector2()

func _ready():
	pass

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	motion = move_and_slide(motion, UP)


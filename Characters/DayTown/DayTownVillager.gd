extends "res://Characters/Character.gd"

var rng = RandomNumberGenerator.new()
const NPC_MAX_SPEED = 30

func _ready():
	pass
	
func _process(delta):
	var move = rng.randi_range(0, 50)
	if move == 1:
		var direction = rng.randi_range(0, 1)
		if direction == 0:
			motion.x = NPC_MAX_SPEED
		if direction == 1:
			motion.x = -NPC_MAX_SPEED
	else:
		motion.x = lerp(motion.x, 0, 0.2)

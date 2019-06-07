extends "res://Characters/Character.gd"

var can_interact = false
var interactable_name = null

func _ready():
	var hero = get_node(".")
	var interactables = get_tree().get_nodes_in_group("Interactable")
	for i in range(interactables.size()):
		var currNode = get_node(interactables[i].get_path())
		var area2DNode = currNode.get_node("Area2D")
		var args = Array([currNode])
		area2DNode.connect("body_enter", hero, "_on_Area2D_body_enter", args)
		area2DNode.connect("body_exit", hero, "_on_Area2D_body_exit", args)

#warning-ignore:unused_argument
func _physics_process(delta):
	#basic movement
	if Input.is_action_pressed("ui_right"):
		motion.x += ACCEL
		motion.x = min(motion.x, MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		motion.x -= ACCEL
		motion.x = max(motion.x, -MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, 0.2)
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT

	if can_interact == true:
		interaction()

func interaction():
		if Input.is_action_just_pressed("interact"):
			get_node("Scripts/dialog_parser").enter_dialog('Doctor')
			print('hi ' + interactable_name)

#on colliding with another interactable, allow interactions
func _on_Area2D_area_entered(area):
	var scene_name = area.get_parent().get_name()
	if (scene_name != "Hero"):
		interactable_name = scene_name
		can_interact = true

#on leaving another interactable, disallow interactions
func _on_Area2D_area_exited(area):
	if (area.get_parent().get_name() != "Hero"):
		can_interact = false
		interactable_name = null
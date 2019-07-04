extends "res://Characters/Character.gd"
const CHAPTER_ONE = "res://Narrative/ChapterOne.json"

signal new_dialogue

var can_interact = false
var can_move = true
var interactable_name = null

var in_dialog = false
var current_dialog = null
var current_dialog_pos = 0
var current_content = null

onready var dialogue_box = get_node("DialogueBoxContainer/DialogueBox")

func _ready():
	current_content = load_narrative(CHAPTER_ONE)
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
	if can_move:
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite.play('running')
			motion.x += ACCEL
			motion.x = min(motion.x, MAX_SPEED)
		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite.play('running')
			motion.x -= ACCEL
			motion.x = max(motion.x, -MAX_SPEED)
		else:
			$AnimatedSprite.play('standing')
			motion.x = lerp(motion.x, 0, 0.2)
		if is_on_floor():
			if Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
	elif !can_move:
		motion.x = 0
		motion.y = 0
		
	if can_interact == true:
		interaction()

func interaction():
		if Input.is_action_just_pressed("interact"):
			#if we are not already talking, start dialog
			if (in_dialog == false):
				enter_dialog(interactable_name)
			#if we are already talking, continue the dialog
			elif (in_dialog == true):
				display_dialog_entry(current_dialog_pos+2)
			
func load_narrative(jsonFile):
	var file = File.new()
	file.open(jsonFile, File.READ)
	var json_content = JSON.parse(file.get_as_text())	
	file.close()
	return json_content.result
	
"""
takes a dialog line and parses the character name and body text

args - dialogue_line = raw text from the json file
returns - line_separated = array of information
"""
func parse_dialogue_line(dialogue_line):
	var name = ""
	var text = ""
	var line_substring = dialogue_line.right(1)
	var line_separated = line_substring.split("-")
	return (line_separated)

func enter_dialog(dialog_tag):
	dialogue_box.set_visible(true)
	var dialog_file = current_content
	in_dialog = true
	can_move = false
	current_dialog = dialog_tag
	var dialog_section = dialog_file.root[2][dialog_tag]
	
	#find the position where the dialog starts (denoted by a ^ symbol)
	var pos = 0
	for item in dialog_section:
		if str(item)[0] == "^":
			current_dialog_pos = pos
			break
		pos = pos+1

	current_dialog = dialog_section
	#show first dialog entry
	display_dialog_entry(0)

func display_dialog_entry(position):
	#check if next position is available
	if current_dialog[position][0] == "^":
		current_dialog_pos = position
		print(current_dialog[position])
		#parsed_dialog[0] == name , parsed_dialog[1] == text
		var parsed_dialog = parse_dialogue_line(current_dialog[position])
		emit_signal("new_dialogue", parsed_dialog[0], parsed_dialog[1])
	#if done, reset all globals
	if current_dialog[position] == "done":
		print('----clear to go-----')
		dialogue_box.set_visible(false)
		current_dialog = null
		current_dialog_pos = 0
		in_dialog = false
		can_move = true

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
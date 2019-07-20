extends KinematicBody2D

const CHAPTER_ONE = "res://Narrative/ChapterOne.json"

signal new_dialogue

var in_dialog = false
var ready_to_proceed = false
var can_interact = false

var current_dialog = null
var current_dialog_pos = 0
var current_content = null

onready var dialogue_box = get_node("DialogueBoxContainer/NarratorDialogueBox")

#Placeholder to hold the scenes - this will help us jump to the correct piece of dialogue
var scene_array = []

func _ready():
	var narrator = get_node(".")
	
	#signal to indicate dialog typing has finished
	dialogue_box.connect("dialog_ended", narrator, "_on_dialog_ended")
	
	current_content = load_narrative(CHAPTER_ONE)
	enter_dialog("LovedOne")
	can_interact = false
	
func _physics_process(delta):
	if in_dialog == true and can_interact == true:
		if Input.is_action_just_pressed("interact"):
			display_dialog_entry(current_dialog_pos+2)
			can_interact = false

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
	var text = ""
	var line_substring = dialogue_line.right(1)
	var line_separated = line_substring.split("-")
	return (line_separated[1])

func enter_dialog(dialog_tag):
	dialogue_box.set_visible(true)
	var dialog_file = current_content
	in_dialog = true
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
		#parsed_dialog == text
		var parsed_dialog = parse_dialogue_line(current_dialog[position])
		emit_signal("new_dialogue", parsed_dialog)
	#if done, reset all globals
	if current_dialog[position] == "done":
		print('----clear to go-----')
		dialogue_box.set_visible(false)
		current_dialog = null
		current_dialog_pos = 0
		in_dialog = false
		
#enable interaction after the dialog has finished typing
func _on_dialog_ended():
	can_interact = true
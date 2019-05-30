const CHAPTER_ONE = "res://Narrative/ChapterOne.json"
var chapter_one_content = null

var in_dialog = false
var current_dialog = null
var current_dialog_pos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	chapter_one_content = load_narrative(CHAPTER_ONE)
	#enter_dialog(chapter_one_content, 'Doctor')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (in_dialog == true):
		if (Input.is_action_just_pressed("ui_accept")):
			display_next_entry()
	if (in_dialog == false):
		if (Input.is_action_just_pressed("ui_right")):
			enter_dialog(chapter_one_content, 'WiseMan')

func load_narrative(jsonFile):
	var file = File.new()
	file.open(jsonFile, File.READ)
	var json_content = JSON.parse(file.get_as_text())	
	file.close()
	return json_content.result
	
func enter_dialog(dialog_file, dialog_tag):
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

func display_next_entry():
	var next_pos = current_dialog_pos+2

	#check if next position is available
	if current_dialog[next_pos][0] == "^":
		current_dialog_pos = next_pos
		print(current_dialog[next_pos])
	#if done, reset all globals
	elif current_dialog[next_pos] == "done":
		current_dialog = null
		current_dialog_pos = 0
		in_dialog = false

func load_globals():
	pass

extends Control

signal dialog_ended

onready var text_name : = get_node("Panel/Columns/Name") as RichTextLabel
onready var text_body : = get_node("Panel/Columns/Dialogue") as RichTextLabel
onready var a_button : = get_node("Panel/Columns/Next") as TextureButton
onready var timer = get_node("TypingTimer")

var loaded_text = ""

func _ready():
	pass

"""
_on_hero_new_dialog - writes text to the dialog box

args	name - name of character
		body - body of dialog
"""
func _on_hero_new_dialogue(name, body):
	loaded_text	= ""
	text_name.set_text(name)
	for i in body:
		#delay for typing text gradually
		yield(timer, "timeout")
		loaded_text = loaded_text + i
		text_body.set_text(loaded_text)
	emit_signal("dialog_ended")
	

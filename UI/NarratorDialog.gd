extends "res://DialogueBox.gd"

func _ready():
	pass

func _on_narrator_new_dialogue(body):
	a_button.set_disabled(true)
	
	loaded_text	= ""
	for i in body:
		#delay for typing text gradually
		yield(timer, "timeout")
		loaded_text = loaded_text + i
		text_body.set_text(loaded_text)
	a_button.set_disabled(false)
	emit_signal("dialog_ended")

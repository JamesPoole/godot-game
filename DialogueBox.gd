extends Control
class_name DialogueBox

signal dialog_ended()

#onready var dialogue_player : DialoguePlayer = get_node("DialoguePlayer")
"""
onready var name : = get_node("Panel/Columns/Name") as RichTextLabel
onready var dialogue : = get_node("Panel/Columns/Dialogue") as RichTextLabel

onready var button_next : = get_node("Panel/Columns/Next") as TextureButton

onready var portrait : = $Portrait as TextureRect

func start(dialogue: Dictionary) -> void:
	button_next.show()
	button_next.grab_focus()
	dialogue_player.start(dialogue)
	update_content()
	show()
	
"""

func _ready():
	pass

extends Control

func _ready():
	pass

func start_game():
	get_tree().change_scene('res://game.tscn')

func _physics_process(delta):
	if Input.is_action_just_released("interact"):
		start_game()

func _on_A_Button_button_up():
	start_game()

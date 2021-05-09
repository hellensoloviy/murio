extends Control

const menu_screen_path = "res://scenes/UI/Menu.tscn"

func _ready():
	pass 

func _on_go_to_title_screen_pressed():
	get_tree().change_scene(menu_screen_path)
	_set_paused(false)

func _on_resume_game_button_pressed():
	self.hide()
	_set_paused(false)


func _set_paused(paused):
	get_tree().paused = paused

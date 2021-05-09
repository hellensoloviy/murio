extends Control

const menu_screen_path = "res://scenes/UI/Menu.tscn"

func _ready():
	pass 

func _on_go_to_title_button_pressed():
	get_tree().change_scene(menu_screen_path)

extends Control

const menu_screen_path = "res://scenes/UI/Menu.tscn"
const start_again_path = "res://MainScene.tscn"

func _ready():
	pass 
	

func _on_go_to_title_screen_pressed():
	get_tree().change_scene(menu_screen_path)


func _on_load_game_button_pressed():
	#TODO: - 
	get_tree().change_scene(start_again_path)

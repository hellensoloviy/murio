extends Control

const menu_screen_path = "res://scenes/UI/Menu.tscn"

func _ready():
	pass 


func _on_back_button_pressed():
	get_tree().change_scene_to_file(menu_screen_path)


func _on_save_button_pressed():
	pass # Replace with function body.


func _on_restore_to_defaults_button_pressed():
	pass # Replace with function body.

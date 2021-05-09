extends Control

const start_game_path = "res://MainScene.tscn"

func _ready():
	pass 

func _on_exit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene(start_game_path)

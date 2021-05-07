extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

func _on_go_to_title_button_pressed():
	get_tree().change_scene("res://GUI/Menu.tscn")

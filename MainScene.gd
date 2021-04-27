extends Node2D


func _ready():
	pass 


func _unhandled_input(event):
	
	if event.is_action_pressed("pause_button"):
			get_tree().change_scene("res://scenes/UI/Pause_screen.tscn")

extends Node2D

@onready var pause_screen = $CanvasLayer/Pause_screen

func _ready():
	pass 

func _unhandled_input(event):
	if event.is_action_pressed("pause_button"):
			get_tree().paused = true
			pause_screen.show()
	

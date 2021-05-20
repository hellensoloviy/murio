extends Control

var heart_full = preload("res://sprites/GUI/hudHeart_full.png")
var heart_empty = preload("res://sprites/GUI/hudHeart_empty.png")


export var current_value = 5
export var max_value = 5
export var step = 1

func _ready():
	update_heart_value(current_value)
	pass 

func update_heart_value(value):
	for i in $bar.get_child_count():
		if i < value:
			$bar.get_child(i).show()
		else: 
			$bar.get_child(i).hide()
		
	pass

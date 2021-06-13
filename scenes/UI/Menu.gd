extends Control

const start_game_path = "res://MainScene.tscn"
const settings_screen_path = "res://scenes/UI/main_settings_screen.tscn"

func _ready():
	$version.text = "Version " + GlobalSettings.VERSION

func _on_exit_button_pressed():
	get_tree().quit()

func _on_start_button_pressed():
	get_tree().change_scene(start_game_path)


func _on_settings_button_pressed():
	get_tree().change_scene(start_game_path)


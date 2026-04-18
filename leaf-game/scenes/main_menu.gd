extends Control

# Drag your Level Selection scene file from the FileSystem onto this line
const LEVEL_SELECT_SCENE = preload("res://scenes/level_selection_menu.tscn")

func _on_start_button_pressed() -> void:
	# 1. Create the Level Selection node
	var level_select = LEVEL_SELECT_SCENE.instantiate()
	
	# 2. Add it as a child of the Main Menu
	add_child(level_select)
	
	# 3. Hide the main menu buttons so they don't overlap
	$Title.hide()
	$startButton.hide()

extends Control

# Drag your Level Selection scene file from the FileSystem onto this line
const LEVEL_SELECT_SCENE = preload("res://scenes/level_selection_menu.tscn")

func _ready() -> void:
	pass

func _on_start_button_pressed() -> void:
	# 3. Create the Level Selection node
	var level_select = LEVEL_SELECT_SCENE.instantiate()
	
	# 4. Add it as a child of the Main Menu
	add_child(level_select)
	
	# 5. Hide the main menu buttons AND the inactive pause menu
	$Title.hide()
	$startButton.hide()
	#pause_menu.hide() # Just in case
	
	# WAKE UP the pause menu so it can start listening for the Escape key!
	#pause_menu.process_mode = PROCESS_MODE_ALWAYS 
	# We keep it hidden, but now its _process(delta) is actually running.
	#pause_menu.hide()

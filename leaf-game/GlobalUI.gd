extends Node

# Preload the scene so the script can "spawn" it
var pause_scene = preload("res://scenes/pause_menu.tscn")
var pause_instance

func _ready():
	self.process_mode = PROCESS_MODE_ALWAYS
	# This creates the menu once at the very start of the game
	pause_instance = pause_scene.instantiate()
	
	# Add it to the "root" so it stays alive during scene changes
	get_tree().root.call_deferred("add_child", pause_instance)
	print(get_tree().root.get_children())
	
	# Start it hidden and disabled so it doesn't block your Start button
	pause_instance.hide()
	pause_instance.process_mode = PROCESS_MODE_DISABLED
	
	pause_instance.show()

func _input(event):
	if event.is_action_pressed("escape"):
		# Optional: Add a check here so you can't pause on the Title Screen
		# if get_tree().current_scene.name == "MainMenu": return
		toggle_pause()

func toggle_pause():
	# If your script is on the child, 'pause_instance' is the CanvasLayer.
	# We want to show/hide the CanvasLayer itself.
	if not pause_instance.visible:
		pause_instance.show()
		# We look for the child node to wake up its script processing
		pause_instance.get_child(0).process_mode = PROCESS_MODE_ALWAYS
		get_tree().paused = true
	else:
		pause_instance.hide()
		pause_instance.get_child(0).process_mode = PROCESS_MODE_DISABLED
		get_tree().paused = false

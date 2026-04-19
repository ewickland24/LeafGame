extends Control

func _ready():
	# Ensures the menu is invisible and reset on startup
	$AnimationPlayer.play("RESET")
	self.hide()
	pass

func pause():
	# This is called by GlobalUI.toggle_pause()
	self.show()
	$AnimationPlayer.play("blur")

func resume():
	# This is called by GlobalUI.toggle_pause()
	$AnimationPlayer.play_backwards("blur")
	# We don't call hide() here because the animation usually 
	# needs time to finish. GlobalUI will hide the CanvasLayer.

func _on_resume_button_pressed() -> void:
	# Talk to the boss to shut everything down correctly
	GlobalUI.toggle_pause()

func _on_restart_button_pressed() -> void:
	GlobalUI.toggle_pause() 
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

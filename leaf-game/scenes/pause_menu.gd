extends Control


# Called when the node enters the scene tree for the first time.
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func test_escape():
	if Input.is_action_just_pressed("esc") and get_tree().paused == false:
		pause()
	if Input.is_action_just_pressed("esc") and get_tree().paused == true:
		resume() 

func _on_resume_button_pressed() -> void:
	resume()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_pressed() -> void:
	get_tree().quit()

extends Node2D
@onready var daLeaf = $CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	if (daLeaf.position.x >= 6000):
		print("i wins")
		# updates the level selection menu with what is unlocked based on
		# if you won the last level
		GlobalLevelManager.current_level += 1
		GlobalLevelManager.unlock_level(GlobalLevelManager.current_level)
		var level_to_load: String = GlobalLevelManager.load_level(GlobalLevelManager.current_level)
		if level_to_load == "":
			return
		get_tree().call_deferred("change_scene_to_file", level_to_load)
	
#	if (daLeaf.is_on_floor() == true):
		print("oh no!")

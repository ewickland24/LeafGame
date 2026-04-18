extends Node

var current_level: int = 0
var level_unlocked: int = 0
var max_level: int = 4

func unlock_level(level_to_unlock: int) -> void:
	if level_to_unlock > level_unlocked:
		level_unlocked = level_to_unlock

func load_level(level_to_load: int) -> String:
	if level_to_load > max_level:
		return ""
	# Use %d to slide the number directly into the string with no spaces
	var path = "res://scenes/levels/level%d.tscn" % level_to_load
	return path


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

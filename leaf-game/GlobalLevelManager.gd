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
	return str("res://scenes/level", level_to_load, ".tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

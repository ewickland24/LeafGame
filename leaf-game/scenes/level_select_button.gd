extends Button


var level: int = 1
var is_unlocked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level = get_index()
	is_unlocked = level <= GlobalLevelManager.level_unlocked
	if !is_unlocked:
		icon = preload("res://assets/sprites/AcornLock.png")

func _pressed() -> void:
	if is_unlocked:
		GlobalLevelManager.current_level = level
		get_tree().call_deferred("change_scene_to_file", GlobalLevelManager.load_level(level))
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

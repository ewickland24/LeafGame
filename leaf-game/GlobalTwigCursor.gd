extends Node

const CURSOR_NORMAL = preload("res://assets/sprites/StickMouse1.png")
const CURSOR_CLICKED = preload("res://assets/sprites/StickMouse2.png")

func _ready() -> void:
	# Set the initial hardware cursor
	Input.set_custom_mouse_cursor(CURSOR_NORMAL, Input.CURSOR_ARROW)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				Input.set_custom_mouse_cursor(CURSOR_CLICKED, Input.CURSOR_ARROW)
			else:
				Input.set_custom_mouse_cursor(CURSOR_NORMAL, Input.CURSOR_ARROW)

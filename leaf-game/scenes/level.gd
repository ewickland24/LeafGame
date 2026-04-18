extends Node2D
@onready var daLeaf = $CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (daLeaf.position.x >= 6000):
		print("i wins")
	
	if (daLeaf.is_on_floor() == true):
		print("oh no!")

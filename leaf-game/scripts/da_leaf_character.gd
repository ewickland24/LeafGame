extends CharacterBody2D
@onready var leafAnimate = $CollisionShape2D/AnimatedSprite2D

@onready var breeze_bar = $"../Camera2D/breezeBar"
@onready var draft_1 = $"../Camera2D/draft1"
@onready var draft_2 = $"../Camera2D/draft2"
@onready var draft_3 = $"../Camera2D/draft3"

@onready var camera_2d = $"../Camera2D"

@onready var breezeBox = $"../Camera2D/BreezeBox"



var daDrafts
var draftNum : int = 3
var totalBreeze = 10.0

var gravityTax := 2
var Y_MAX_SPEED := 800
var X_MAX_SPEED := 1200
var loftTax := 0.03
var maxBreeze := 0.0

var rotation_speed := 2.2
var magnitude := 0.0
var loft : float = 0.0
var leafFlow : float = 0.0
var inputSettings : int = 1
var gameOver : bool = false

var enviornment : int = 0

func _ready():
	daDrafts = [draft_1, draft_2, draft_3]
	
	# use global level manager

func _physics_process(delta):
	
	# make camera with elements follow
	camera_2d.position.x = min(7500, max(1000, position.x))
	camera_2d.position.y = max( 120, min(1100, position.y))
	
	
	# swap from keys to mouse controlls
	if Input.is_action_just_pressed("ui_accept"):
		inputSettings = inputSettings * -1
	
	# player rotation control 
	if (not gameOver):
		if (sign(inputSettings) == -1):
			look_at(get_global_mouse_position())
		else:
			if Input.is_action_pressed("left"):
				rotation -= rotation_speed * delta
			elif Input.is_action_pressed("right"):
				rotation += rotation_speed * delta
	
	# magnitude of speed based on facing
	magnitude += abs(rotation)
	magnitude = abs(0.99 * magnitude) * sign(rotation)
	magnitude = max(-Y_MAX_SPEED, min(Y_MAX_SPEED, magnitude))
	
	# allowing players to use breeze
	if (Input.is_action_pressed("breeze") && totalBreeze > 0 && rotation != 0.0):
		totalBreeze -= 0.1
		breezeBox.scale.x = 10 * (totalBreeze/maxBreeze)
		breezeBox.position.x -= 3.3
		velocity.x += 3 * cos(rotation)
		velocity.y -= 10.0 * abs(sin(rotation))
		loft -= 0.05
	
	if (Input.is_action_just_pressed("upDraft") && draftNum > 0 && rotation != 0.0):
		draftNum -= 1
		daDrafts[draftNum].visible = false
		loft = 0.0
		magnitude = 0.0
		velocity.y = min(-400, velocity.y)
		velocity.y -= 400
	
	#make the player travel with less momentum the longer they look up
	if (sign(magnitude) == -1):
		magnitude += loft
		loft += loftTax
	else:
		if(loft > 1):
			loft = loft * 0.99
		else:
			loft = 0.0
	
	# calculate x velocity
	if (sign(rotation) == 1):
		leafFlow = leafFlow + 0.1 * magnitude
		velocity.x += 0.01 * leafFlow * cos(rotation) 
	else:
		leafFlow = 0.1 * leafFlow
		velocity.x += sin(rotation) * 5
	
	# set max speeds
	velocity.x = max(-X_MAX_SPEED/5.0, min(X_MAX_SPEED, velocity.x))
	velocity.y += magnitude + gravityTax * delta
	velocity.y = max(-Y_MAX_SPEED, min(Y_MAX_SPEED, velocity.y))
	
	if (rotation == 0.0):
		velocity.y = 0
	
	# ending game run
	if (is_on_floor()):
		gameOver = true
		velocity.y = 0
		velocity.x = 0
	
	# --- Move ---
	move_and_slide()


func loadingLeaf(numba):
	enviornment = numba
	leafAnimate.play("leaf"+str(numba))
	
	if(enviornment == 0):
		draftNum = 3
		totalBreeze = 20.0
		maxBreeze = 20.0
		gravityTax = 2
		Y_MAX_SPEED = 800
		X_MAX_SPEED = 1200
		loftTax = 0.03
	elif(enviornment == 1):
		draftNum = 2
		totalBreeze = 15.0
		maxBreeze = 15.0
		gravityTax = 2
		Y_MAX_SPEED = 800
		X_MAX_SPEED = 1200
		loftTax = 0.04
		daDrafts[2].visible = false
	elif(enviornment == 2):
		draftNum = 1
		totalBreeze = 10.0
		maxBreeze = 10.0
		gravityTax = 2
		Y_MAX_SPEED = 800
		X_MAX_SPEED = 1200
		loftTax = 0.05
		daDrafts[2].visible = false
		daDrafts[1].visible = false
	elif(enviornment == 3):
		draftNum = 0
		totalBreeze = 5.0
		maxBreeze = 5.0
		gravityTax = 2
		Y_MAX_SPEED = 800
		X_MAX_SPEED = 1200
		loftTax = 0.06
		daDrafts[2].visible = false
		daDrafts[1].visible = false
		daDrafts[0].visible = false
	else:
		draftNum = 3
		totalBreeze = 10.0
		gravityTax = 2
		Y_MAX_SPEED = 10000
		X_MAX_SPEED = 10000
		loftTax = 0.03

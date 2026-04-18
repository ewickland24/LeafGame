extends CharacterBody2D

var gravityTax := 2
var rotation_speed := 2.2
var Y_MAX_SPEED := 800
var X_MAX_SPEED := 1200
var magnitude := 0.0
var loft : float = 0.0
var leafFlow : float = 0.0
var inputSettings : int = 1
var gameOver : bool = false


#func

func _physics_process(delta):
	
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
	if (Input.is_action_pressed("breeze")):
		velocity.x += 3 * cos(rotation)
		velocity.y -= 10.0 * abs(sin(rotation))
		loft -= 0.05
	
	if (Input.is_action_just_pressed("upDraft")):
		loft = 0.0
		magnitude = 0.0
		velocity.y = min(-600, velocity.y)
		velocity.y -= 600
	
	#make the player travel with less momentum the longer they look up
	if (sign(magnitude) == -1):
		magnitude += loft
		loft += 0.03
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

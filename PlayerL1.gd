extends KinematicBody2D

# Movement variables
var normal_speed = 200
var sprint_speed = 400  # Speed when sprinting
var velocity = Vector2.ZERO
var is_sprinting = false

func _ready():
	$AnimatedSprite.play("Idle_Down")

func _physics_process(delta):
	get_input()
	move_and_animate(delta)

# Get player input
func get_input():
	velocity = Vector2.ZERO
	is_sprinting = Input.is_action_pressed("ui_sprint")
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1

	# Apply speed (sprint or normal)
	var speed = sprint_speed if is_sprinting else normal_speed
	velocity = velocity.normalized() * speed

# Move and animate the player
func move_and_animate(delta):
	if velocity.length() > 0:
		# Move the player
		move_and_slide(velocity)
		
		# Animation control with sprint support
		if abs(velocity.y) > abs(velocity.x):  # Vertical movement has priority
			if velocity.y > 0:
				$AnimatedSprite.play("Sprint_Down" if is_sprinting else "Walk_Down")
			else:
				$AnimatedSprite.play("Sprint_Up" if is_sprinting else "Walk_Up")
		else:  # Horizontal movement
			if velocity.x > 0:
				$AnimatedSprite.play("Sprint_Right" if is_sprinting else "Walk_Right")
			else:
				$AnimatedSprite.play("Sprint_Left" if is_sprinting else "Walk_Left")
	else:
		# Idle animation based on direction
		if $AnimatedSprite.animation.begins_with("Walk") or $AnimatedSprite.animation.begins_with("Sprint"):
			var direction = $AnimatedSprite.animation.split("_")[1]
			$AnimatedSprite.play("Idle_" + direction)

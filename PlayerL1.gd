extends KinematicBody2D

# Movement
var normal_speed = 200
var sprint_speed = 400
var velocity = Vector2.ZERO
var is_sprinting = false
var current_direction = "Down"

# Preload fireball scene
var fireball_scene = preload("res://Fireball.tscn")  # Update the path if needed

func _ready():
	$AnimatedSprite.play("Idle_Down")

func _physics_process(delta):
	get_input()
	move_and_animate(delta)

# Handle input
func get_input():
	velocity = Vector2.ZERO
	is_sprinting = Input.is_action_pressed("ui_sprint")

	# Directional input
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		current_direction = "Up"
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		current_direction = "Down"
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		current_direction = "Left"
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		current_direction = "Right"

	# Attack input
	if Input.is_action_just_pressed("ui_attack"):
		spawn_fireball()

	# Apply speed
	var speed = sprint_speed if is_sprinting else normal_speed
	velocity = velocity.normalized() * speed

# Move and animate
func move_and_animate(delta):
	if velocity.length() > 0:
		move_and_slide(velocity)
		update_animation()
	else:
		$AnimatedSprite.play("Idle_" + current_direction)

# Animation handling
func update_animation():
	if abs(velocity.y) > abs(velocity.x):
		if velocity.y > 0:
			current_direction = "Down"
			$AnimatedSprite.play("Sprint_Down" if is_sprinting else "Walk_Down")
		else:
			current_direction = "Up"
			$AnimatedSprite.play("Sprint_Up" if is_sprinting else "Walk_Up")
	else:
		if velocity.x > 0:
			current_direction = "Right"
			$AnimatedSprite.play("Sprint_Right" if is_sprinting else "Walk_Right")
		else:
			current_direction = "Left"
			$AnimatedSprite.play("Sprint_Left" if is_sprinting else "Walk_Left")

# Fireball spawner
func spawn_fireball():
	var fireball = fireball_scene.instance()

	var offset = 16  # How far in front of player to spawn fireball
	match current_direction:
		"Up":
			fireball.direction = Vector2(0, -1)
			fireball.global_position = global_position + Vector2(0, -offset)
		"Down":
			fireball.direction = Vector2(0, 1)
			fireball.global_position = global_position + Vector2(0, offset)
		"Left":
			fireball.direction = Vector2(-1, 0)
			fireball.global_position = global_position + Vector2(-offset, 0)
		"Right":
			fireball.direction = Vector2(1, 0)
			fireball.global_position = global_position + Vector2(offset, 0)

	get_parent().add_child(fireball)

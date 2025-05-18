extends KinematicBody2D

export var walk_speed := 150
export var run_speed := 300
var velocity := Vector2.ZERO
var last_direction := "down"
var can_move := true

onready var anim_sprite := $AnimatedSprite

func _physics_process(delta):
	if not can_move:
		anim_sprite.stop()
		return

	velocity = Vector2.ZERO

	# Movement input
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Sprint logic
	var is_sprinting = Input.is_action_pressed("Sprint")
	var speed = walk_speed
	var anim_prefix = "walk_"
	if is_sprinting:
		speed = run_speed
		anim_prefix = "run_"

	# Normalize velocity to prevent diagonal speed boost
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)

	# Animation
	if velocity != Vector2.ZERO:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				anim_sprite.play(anim_prefix + "right")
				last_direction = "right"
			else:
				anim_sprite.play(anim_prefix + "left")
				last_direction = "left"
		else:
			if velocity.y > 0:
				anim_sprite.play(anim_prefix + "down")
				last_direction = "down"
			else:
				anim_sprite.play(anim_prefix + "up")
				last_direction = "up"
	else:
		anim_sprite.stop()
		anim_sprite.frame = 0

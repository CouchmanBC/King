extends KinematicBody2D

export var walk_speed = 150
export var run_speed = 300

var velocity = Vector2.ZERO
var last_direction = "down"

onready var anim_sprite = $AnimatedSprite

func _physics_process(delta):
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

	# Sprint check
	var is_sprinting = Input.is_action_pressed("Sprint")  # 'Sprint' should be defined in Input Map
	var speed = walk_speed
	var anim_prefix = "walk_"
	if is_sprinting:
		speed = run_speed
		anim_prefix = "run_"

	# Normalize movement to avoid diagonal speed boost
	velocity = velocity.normalized() * speed
	move_and_slide(velocity)

	# Animation logic
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
		anim_sprite.frame = 0  # Optional: show idle frame

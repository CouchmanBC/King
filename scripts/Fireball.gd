extends Node2D

var direction = Vector2.ZERO
var speed = 400

func _physics_process(delta):
	position += direction.normalized() * speed * delta

	# Optional: remove after going too far
	if position.length() > 2000:
		queue_free()

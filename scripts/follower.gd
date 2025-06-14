extends KinematicBody2D

export var follow_speed = 100
onready var player = get_parent().get_node("Player")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		var distance = global_position.distance_to(player.global_position)

		# Optional: Only move if not too close
		if distance > 20:
			move_and_slide(direction * follow_speed)

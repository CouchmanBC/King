extends Area2D

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.name == "MiniPlayer":
		print("Maze completed!")
		var player = get_tree().get_root().find_node("Player", true, false)
		if player:
			player.can_move = true  # Re-enable movement
		get_parent().queue_free()  # Remove the maze scene

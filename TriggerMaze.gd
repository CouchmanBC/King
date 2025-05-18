extends Area2D

export(PackedScene) var MazeScene
onready var MazeContainer = get_node("/root/Node2D/MazeContainer")

func _on_TriggerMaze_body_entered(body):
	if body.name == "Player":
		var maze = MazeScene.instance()
		MazeContainer.add_child(maze)

		# Disable player movement
		body.can_move = false

		# Optional: disable this trigger
		set_monitoring(false)

extends Area2D

export(String) var next_scene_path = "res://End.tscn"  # Adjust path

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _on_body_entered(body):
	if body.name == "Player":  # Or use `body is KinematicBody2D` if unsure
		get_tree().change_scene(next_scene_path)

extends Control

# The next scene path (adjust this path to your next scene)
export(String) var next_scene = "res://MainMenu.tscn"

func _ready():
	# Attempt to get the TransitionTimer node
	var timer = get_node("TransitionTimer")
	
	if timer:
		# Connect the timer's timeout signal to trigger scene change
		timer.connect("timeout", self, "_on_TransitionTimer_timeout")
		print("TransitionTimer found and connected.")
	else:
		print("Error: TransitionTimer not found. Make sure it is correctly named and a direct child of this Control node.")

func _on_TransitionTimer_timeout():
	# Change to the next scene when the timer ends
	if next_scene != "":
		get_tree().change_scene(next_scene)
	else:
		print("Error: next_scene is not set.")

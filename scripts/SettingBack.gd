extends Button

func _ready():
	# Connect the button's pressed signal to itself (since it is a button)
	connect("pressed", self, "_on_button_pressed")

func _on_button_pressed():
	# Directly set the scene without needing an exported variable
	get_tree().change_scene("res://MainMenu.tscn")

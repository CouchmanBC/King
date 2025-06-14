extends Camera2D

# Smoothly follow the player
var player = null


func _ready():
	player = get_parent().get_node("Player")  # Adjust this path if necessary

func _process(delta):
	if player:
		global_position = global_position.linear_interpolate(player.global_position, delta * smoothing_speed)

extends Camera2D

var current_viewport_size

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_viewport_size = get_viewport().size
	zoom.x = (current_viewport_size.y / 648) * 7.5
	zoom.y = (current_viewport_size.y / 648) * 7.5

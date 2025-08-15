extends Control

@onready var label = $Label
@onready var label_2 = $Label2

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2.5).timeout
	label.visible = true
	await get_tree().create_timer(2.5).timeout
	label_2.visible = true
	await get_tree().create_timer(2.5).timeout
	get_tree().change_scene_to_file("res://assets/scenes/map.tscn")

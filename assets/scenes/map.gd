extends Node2D

@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0

@onready var timer = $Timer
@onready var player = $CharacterBody2D
@onready var random = RandomNumberGenerator.new()
@onready var button = $Button

var shake_strength: float = 0.0

func _ready():
	random.randomize()
	timer.wait_time = random.randf_range(15, 45)
	timer.start()

func _on_timer_timeout():
	apply_shake()
	timer.wait_time = random.randf_range(15, 45)

func apply_shake():
	shake_strength = RANDOM_SHAKE_STRENGTH

func _process(delta):
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	player.camera.offset = get_random_offset()

func get_random_offset():
	return Vector2(
		random.randf_range(-shake_strength, shake_strength), 
		random.randf_range(-shake_strength, shake_strength)
	)

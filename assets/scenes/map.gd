extends Node2D

@export var RANDOM_SHAKE_STRENGTH = 30.0
@export var SHAKE_DECAY_RATE = 5.0

@onready var timer = $Timer
@onready var player = $CharacterBody2D
@onready var random = RandomNumberGenerator.new()
@onready var button = $Button

var shake_strength = 0.0

var areas_unlocked = 0

var entered_zone_1 = false
var entered_zone_2 = false
var entered_zone_3 = false
var entered_zone_4 = false
var entered_zone_5 = false

func _ready():
	random.randomize()
	timer.wait_time = random.randf_range(15, 25)
	timer.start()

func _on_timer_timeout():
	apply_shake()
	timer.wait_time = random.randf_range(15, 45)

func apply_shake():
	shake_strength = RANDOM_SHAKE_STRENGTH

func _process(delta):
	print(player.global_transform.origin)
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)
	player.camera.offset = get_random_offset()

func get_random_offset():
	return Vector2(
		random.randf_range(-shake_strength, shake_strength), 
		random.randf_range(-shake_strength, shake_strength)
	)

func _physics_process(delta):
	player.label.text = "Areas Unlocked: " + str(areas_unlocked) + "/5"
	if player.position.x >= 100 and not entered_zone_1:
		entered_zone_1 = true
		areas_unlocked += 1
	if player.position.x >= 1350 and not entered_zone_2:
		entered_zone_2 = true
		areas_unlocked += 1
	if player.position.x >= 2690 and not entered_zone_3:
		entered_zone_3 = true
		areas_unlocked += 1
	if player.position.x >= 4550 and not entered_zone_4:
		entered_zone_4 = true
		areas_unlocked += 1

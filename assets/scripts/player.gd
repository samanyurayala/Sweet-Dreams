extends CharacterBody2D

@onready var player_anim = $AnimatedSprite2D
@onready var camera = $Camera2D

var speed = 40.0
var jump_velocity = -250.0


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	
	if Input.is_action_pressed("Sprint"):
		speed = 75
		jump_velocity = -300
	else:
		speed = 40
		jump_velocity = -250
	
	if direction > 0:
		player_anim.flip_h = false
	elif direction < 0:
		player_anim.flip_h = true
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	
	_animations()
	
func _animations():
	if velocity.x == 0 and velocity.y == 0:
		player_anim.pause()
	if velocity.x != 0 and velocity.y == 0:
		if speed == 75:
			player_anim.play("run")
		else:
			player_anim.play("walk")
	if velocity.x != 0 and velocity.y != 0:
		player_anim.play("run_jump")
	if velocity.x == 0 and velocity.y != 0:
		player_anim.play("jump")

extends CharacterBody2D

@onready var player_anim = $AnimatedSprite2D
@onready var camera = $Camera2D
@onready var label = $Camera2D/Label
@onready var label_2 = $Camera2D/Label2
@onready var label_3 = $Camera2D/Label3
@onready var label_4 = $Camera2D/Label4

var speed = 40.0
var jump_velocity = -250.0
var player_direction

var reset = false
var player_ate_potion = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor() and position.x < 4946.673 and not Input.is_action_pressed("Up"):
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity
		
	if Input.is_action_pressed("Up") and position.x >= 4946.673:
		position.y -= 2
	if Input.is_action_pressed("Down") and position.x >= 4946.73:
		position.y += 2

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	
	if Input.is_action_pressed("Sprint"):
		speed = 75
		jump_velocity = -300
	else:
		speed = 40
		jump_velocity = -250
		
	if player_ate_potion:
		jump_velocity = -400
	
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


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		reset = true
	if area.is_in_group("Potion"):
		player_ate_potion = true
		label_3.visible = true
		await get_tree().create_timer(2).timeout
		label_3.visible = false
		

extends CharacterBody2D

@onready var down = $Down
@onready var right = $Right
@onready var left = $Left
@onready var zombie_anim = $AnimatedSprite2D

const SPEED = 70.0

var direction = 1

func _physics_process(delta):
	if not down.is_colliding() or right.is_colliding() or left.is_colliding():
		direction = direction * -1
	
	if direction > 0:
		zombie_anim.flip_h = false
	elif direction < 0:
		zombie_anim.flip_h = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = direction * SPEED

	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Bullet"):
		print("successful")
		position.x = 0
		position.y = 1500

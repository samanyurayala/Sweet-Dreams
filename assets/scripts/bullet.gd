extends CharacterBody2D

var direction = 1

const SPEED = 300.0


func _physics_process(delta):
	velocity.x = direction * SPEED
	
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("Enemy"):
		position.x = 0
		position.y = 0

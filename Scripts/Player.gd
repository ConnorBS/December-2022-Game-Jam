extends KinematicBody2D


export (int) var speed = 50 
export (int) var top_speed =400
export (int) var gravity = 1000
export (int) var jumpStrength = 600


var velocity = Vector2(0,0)


func _process(delta):
	velocity.x = velocity.x + speed
	if velocity.x > top_speed:
		velocity.x = top_speed

	velocity.y = velocity.y + gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)

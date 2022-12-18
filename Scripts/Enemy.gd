extends KinematicBody2D


export var speed = 150
export var motion = Vector2()
export var gravity = 20

var direction = 1

func _physics_process(delta):
	motion.y += gravity
	motion.x =+ speed * direction
	if is_on_wall():
		direction = direction * -1
	motion = move_and_slide(motion,Vector2.UP)
	
	
	


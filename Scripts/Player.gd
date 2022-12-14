extends KinematicBody2D



export var speed: = Vector2(200,500)
export var gravity: = 2500.0
export var top_speed =400
export var jumpstrength = 1000

var velocity : = Vector2.ZERO

func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta
	if velocity.y > speed.y:
		velocity.y = speed.y
	velocity = move_and_slide(velocity)
	var direction := Vector2(
		Input.get_action_strength("move right") - Input.get_action_strength("move left"),1.0
		)
	
	velocity = speed * direction


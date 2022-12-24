extends KinematicBody2D



export (int) var speed = 50 
export (int) var top_speed =400
export (int) var gravity = 1000
export (int) var jumpStrength = 600

var velocity = Vector2(0,0)

##########################
var double_jump = false


func _ready():
	$AnimationPlayer.play("RunForwards")


func _process(delta):
	########################
	if is_on_floor():
		double_jump = false
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = velocity.y - jumpStrength
			print("Jump Pressed: ", velocity)
		if velocity.y >= 0 and double_jump == false:
			velocity.y = velocity.y - jumpStrength
			double_jump = true
	if Input.is_action_just_pressed("jump") and is_on_wall():
		velocity.y = 0 - jumpStrength
		print("Jump Pressed: ", velocity)
	
		##########################
		
	if Input.is_action_pressed("move left"):
		velocity.x = velocity.x - speed
		if velocity.x < -top_speed:
			velocity.x = -top_speed
	elif Input.is_action_pressed("move right"):
		velocity.x = velocity.x + speed
		if velocity.x > top_speed:
			velocity.x = top_speed
	else:
		velocity.x = velocity.x / 1.5
		
	
	
	velocity.y = velocity.y + gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	
	

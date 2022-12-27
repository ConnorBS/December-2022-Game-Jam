extends KinematicBody2D



export (int) var speed = 50 
export (int) var top_speed =400
export (int) var gravity = 1000
export (int) var jumpStrength = 600
export (float) var max_angle_speed = 12.5
export (int) var angle_rotation_speed = 10
var velocity = Vector2(0,0)

var slowing_down =false
var old_velocity
##########################
var double_jump = false

#
#func _ready():
#	$AnimationPlayer.play("RunForwards")


func _process(delta):
	old_velocity = velocity
	########################
	if is_on_floor():
		double_jump = false
	
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
#			print (velocity)
			velocity.y = velocity.y - jumpStrength
#			print("Jump Pressed: ", velocity)
		if velocity.y >= 0 and double_jump == false:
			velocity.y = velocity.y - jumpStrength
			double_jump = true
#	if Input.is_action_just_pressed("jump") and is_on_wall():
#		velocity.y = 0 - jumpStrength
#		print("Jump Pressed: ", velocity)
	
		##########################
#
	if Input.is_action_pressed("move left"):
		velocity.x = velocity.x / 1.5
		
#		velocity.x = velocity.x - speed
#		if velocity.x < -top_speed:
#			velocity.x = -top_speed
#	if Input.is_action_pressed("move right"):
	else:
		velocity.x = velocity.x + speed
	if velocity.x > top_speed:
		velocity.x = top_speed
#	else:
#		velocity.x = velocity.x / 1.5


	velocity.y = velocity.y + gravity * delta
	velocity = move_and_slide(velocity,Vector2.UP)
	
	if old_velocity.x > velocity.x:
		slowing_down = true
	elif slowing_down == true and velocity.x < top_speed:
		slowing_down = false
	
	var new_rotation = rotation_degrees
#	if Input.is_action_pressed("move right"):
#	if slowing_down:
##		new_rotation =(delta*angle_rotation_speed)*(velocity.x/top_speed)
#		new_rotation = velocity.x*top_speed/delta/angle_rotation_speed
#	else:
	new_rotation += (delta*angle_rotation_speed)*(velocity.x/top_speed)
	print("(",(delta*angle_rotation_speed)*(velocity.x/top_speed), "=",new_rotation)
#	else:
#		new_rotation -= (delta*angle_rotation_speed*2)
	if new_rotation > max_angle_speed:
		new_rotation = max_angle_speed
	elif new_rotation < 0:
		new_rotation = 0
	rotation_degrees = new_rotation
#	print(new_rotation)
	
	

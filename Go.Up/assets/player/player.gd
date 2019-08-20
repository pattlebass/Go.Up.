extends KinematicBody2D

var speed = 400
var jumpforce = 800
var hp = 5
var velocity = Vector2()
var gravity = 15
var timer = 0

func _physics_process(delta):
	movement()
	
	#timer
	timer += delta
	if timer >= 0.5:
		print(velocity)
		timer = 0
	
func movement():
	if Input.is_action_pressed("left"):
		velocity.x = -speed
	elif Input.is_action_pressed("right"):
		velocity.x = speed
	else:
		velocity.x = 0
	if Input.is_action_pressed("jump") && is_on_floor():
		velocity.y -= jumpforce
	elif Input.is_action_pressed("jump") && !(Input.is_action_pressed("left") or Input.is_action_pressed("right")) && is_on_wall():
		velocity.y = -jumpforce
	elif is_on_floor() or is_on_ceiling() or is_on_wall():
		velocity.y = 0
	if Input.is_action_just_released("jump") && velocity.y < -250:
		velocity.y = -600
	velocity.y += gravity
	move_and_slide(velocity, Vector2.UP)
	
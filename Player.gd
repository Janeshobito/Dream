extends KinematicBody2D

# Declare member variables here
const UP = Vector2(0, -1)
const GRAVITY = 15
const ACCELARATION = 60
const JUMP_HEIGHT = 400
const MAX_SPEED = 200
var double_jump = true
var velocity = Vector2()
onready var hero = $AnimatedSprite



func _physics_process(delta):
	velocity.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("jump"):
			jump()
		else:
			run_right()
	
	elif Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("jump"):
			jump()
		else:
			run_left()
	
	elif Input.is_action_pressed("jump"):
		jump()
	
	elif !is_on_floor():
		hero.play("Jump")
		
	else:
		velocity.x = 0
		hero.play("Idle")
	
		
	
	velocity = move_and_slide(velocity, UP)
	


func run_right():
	velocity.x = min(velocity.x + ACCELARATION, MAX_SPEED)
	hero.flip_h = false
	if is_on_floor():
		hero.play("Run")
	else:
		hero.play("Jump")
	
func run_left():
	velocity.x = max(velocity.x-ACCELARATION, -MAX_SPEED)
	hero.flip_h = true
	if is_on_floor():
		hero.play("Run")
		
	else:
		hero.play("Jump")
	
func jump():
	if is_on_floor():
		velocity.y = -JUMP_HEIGHT
		hero.play("Jump")
		double_jump = true
	if velocity.y > 0 and double_jump:
			velocity.y = -JUMP_HEIGHT
			hero.play("Jump")
			double_jump = false

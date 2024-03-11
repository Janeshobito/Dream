extends KinematicBody2D

const bullet = preload("res://bullet.tscn")
# Declare member variables here
const UP = Vector2(0, -1)
const GRAVITY = 15
const ACCELARATION = 60
const JUMP_HEIGHT = 400
const MAX_SPEED = 200
var count = 0
var double_jump = true
var velocity = Vector2()
onready var hero = $AnimatedSprite
onready var muzzle : Position2D = $Muzzle

var muzzle_position #used to store muzzle position
var hero_direction = 1

#program code
func _ready():
	muzzle_position = muzzle.position

func _physics_process(delta):
	velocity.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		if Input.is_action_pressed("jump"):
			jump()
		elif Input.is_action_pressed("shoot"):
			run_shoot()
		else:
			run_right()
	
	elif Input.is_action_pressed("ui_left"):
		if Input.is_action_pressed("jump"):
			jump()
		elif Input.is_action_pressed("shoot"):
			run_shoot()
		else:
			run_left()
	
	elif Input.is_action_pressed("jump"):
		jump()
	
	elif Input.is_action_pressed("shoot"):
		if is_on_floor():
			shoot()
	
	elif Input.is_action_pressed("ui_down"):
		if is_on_floor():
			crouch()
	
	elif !is_on_floor():
		hero.play("Jump")
		
	else:
		velocity.x = 0
		hero.play("Idle")
	
		
	
	velocity = move_and_slide(velocity, UP)
	


func run_right():
	velocity.x = min(velocity.x + ACCELARATION, MAX_SPEED)
	hero_direction = 1
	hero.flip_h = false
	if Input.is_action_pressed("shoot"):
		hero.play("RunShoot")
	elif is_on_floor():
		hero.play("Run")
	else:
		hero.play("Jump")
	
func run_left():
	velocity.x = max(velocity.x-ACCELARATION, -MAX_SPEED)
	hero_direction = -1
	hero.flip_h = true
	if Input.is_action_pressed("shoot"):
		hero.play("RunShoot")
	elif is_on_floor():
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
			
func player_muzzle_position():
	if hero_direction > 0:
		muzzle.position.x = muzzle_position.x
	elif hero_direction < 0:
		muzzle.position.x = -muzzle_position.x

func shoot():
	var direction = hero_direction
	hero.play("Shoot")
	velocity.x = 0
	muzzle.position.x = 22
	muzzle.position.y = -17
	player_muzzle_position()
	
	if count == 0:
		var bullet_instance = bullet.instance() as Node2D
		bullet_instance.direction = direction 
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
	count = count + 1
	if count == 10:
		count = 0
		
		
func run_shoot():
	var direction = hero_direction
	
	if Input.is_action_pressed("ui_right"):
		run_right()
	elif Input.is_action_pressed("ui_left"):
		run_left()
			 
	hero.play("RunShoot")
	muzzle_position.x = 35
	muzzle.position.y = -13
	player_muzzle_position()
	
	if count == 0:
		var bullet_instance = bullet.instance() as Node2D
		bullet_instance.direction = direction 
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
	count = count + 1
	if count == 10:
		count = 0

func crouch():
	var direction = hero_direction
	hero.play("Crouch")
	velocity.x = 0
	muzzle.position.x = 22
	muzzle.position.y = 1
	player_muzzle_position()
	
	if count == 0:
		var bullet_instance = bullet.instance() as Node2D
		bullet_instance.direction = direction 
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
	count = count + 1
	if count == 10:
		count = 0

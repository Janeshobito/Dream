extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const UP = Vector2(0,-1)
const GRAVITY = 15
const ACCELARATION = 100
const JUMP_HEIGHT = -550
const MAX_SPEED = 200
var motion = Vector2()


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var friction = false
	motion.y += GRAVITY
	
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELARATION, MAX_SPEED)
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("run")
		
		
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELARATION, -MAX_SPEED)
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("run")
		
	else:
		$AnimatedSprite.play("idle")
		friction = true
		
		
		
	if is_on_floor():
		print("onfloor")
		if Input.is_action_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true :
			motion.x = lerp(motion.x, 0, 0.2)
			
	
			
	else:
		print("not on floor")
		if motion.y < 0:
		   $AnimatedSprite.play("jump")
		else:
			$AnimatedSprite.play("fall")
		if friction == true :
			motion.x = lerp(motion.x, 0, 0.05)
		#if Input.is_action_just_released("ui_up"):
			#motion.y = 0
			#$Sprite.play("idle")
	

	
	 
	motion = move_and_slide(motion, UP)
	pass 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


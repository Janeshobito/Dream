extends KinematicBody2D

onready var animated_sprite_2d = $AnimatedSprite2d


const UP = Vector2(0, -1)
const GRAVITY = 1000
const SPEED = 200
const JUMP = -300
const JUMP_HORIZONTAL = 100

enum state { Idle, Run, jump }

var current_state 
var velocity = Vector2()

func _ready():
	current_state = state.Idle
	
			

			
func _physics_process(_delta):
	player_falling(_delta)
	player_idle(_delta)
	player_run(_delta)
	player_jump(_delta)
	
	player_animation()
	
	velocity = move_and_slide(velocity, UP)
	

	
func player_falling(_delta):
	if !is_on_floor():
		velocity.y += GRAVITY * _delta
		
func player_idle(_delta):
	if is_on_floor():
		#print("floor")
		current_state = state.Idle
		
func player_run(_delta):
	if !is_on_floor():
		#print("Not in floor")
		return
	
	var  direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		 velocity.x = direction * SPEED
	else:
		 velocity.x = move_toward(velocity.x, 0, SPEED)
		 
		 
		
	if direction != 0:
			current_state = state.Run
			animated_sprite_2d.flip_h = false if direction > 0 else true 
			
func player_jump(_delta):
	if Input.is_action_pressed("jump"):
		velocity.y = JUMP       
		current_state = state.jump
		
	
	elif !is_on_floor() and current_state == state.jump:
		var  direction = Input.get_axis("ui_left", "ui_right")
		velocity.x += direction * JUMP_HORIZONTAL * _delta
		animated_sprite_2d.flip_h = false if direction >= 0 else true

			
			
			
	
		
			
		
func player_animation():
	
	if current_state == state.Idle:
		animated_sprite_2d.play("Idle ")
	elif current_state == state.Run:
		animated_sprite_2d.play("run")
	elif current_state == state.jump:
		animated_sprite_2d.play("jump")
	
		
		
		
		
		#animation_player.play("Idle")
		

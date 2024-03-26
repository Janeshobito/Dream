extends KinematicBody2D

const bullet = preload("res://EnemyBulletCity.tscn")

export(NodePath) var PatrolPoints
onready var patrol_points = get_node(PatrolPoints)

export(NodePath) var Hero
onready var hero = get_node(Hero)

export(int) var speed = 50
export(int) var wait_time = 3
export(Vector2) var direction = Vector2.LEFT
export(int) var HEALTH : int = 5


onready var timer = $Timer
onready var enemy = $AnimatedSprite
onready var muzzle : Position2D = $Muzzle

# Declare member variables here. 
const GRAVITY = 20
var health_amount = HEALTH
var motion : Vector2 = Vector2()
var number_of_points : int
var point_positions : Array = []
var current_point : Vector2
var current_point_position : int
var hero_position : int
var muzzle_position #used to store muzzle position
var can_walk : bool
var death : bool = false
var can_shoot : bool
var shoot : bool

func _ready():
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
		
	else:
		print("No patrol points")
		
	if hero == null:
		print("No hero assigned")
		
	$HealthBar.max_value = HEALTH
	set_health_bar()
	timer.wait_time = wait_time
	can_shoot = false 
	shoot = true
	muzzle_position = muzzle.position

func _physics_process(delta):
	motion.y += GRAVITY + delta
	
	walk(delta)
	idle()
	hero_direction()
	shoot()
	
	motion = move_and_slide(motion)
	
	
func set_health_bar():
	$HealthBar.value = health_amount

func walk(delta):
	if !can_walk:
		return
	if death:
		return
	if can_shoot:
		return
	
	if abs(position.x - current_point.x) > 1:
		move_local_x(direction.x * speed * delta)
		enemy.play("Walk")
	else:
		if current_point_position == 0:
			current_point_position += 1
		else:
			current_point_position = 0
	
		current_point = point_positions[current_point_position]
	
		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else:
			direction = Vector2.LEFT
		
		can_walk = false
		timer.start()
	
	enemy.flip_h = direction.x < 0
	
	
func shoot():
	var Direction = hero_position
	if can_shoot and shoot: 
		player_muzzle_position()
		motion.x = 0
		enemy.play("shoot")
		var bullet_instance = bullet.instance() as Node2D
		bullet_instance.direction = Direction
		bullet_instance.global_position = muzzle.global_position
		get_parent().add_child(bullet_instance)
		shoot = false


func idle():
	if death:
		return
	if can_shoot:
		return
	
	if !can_walk:
		motion.x = 0
		enemy.play("Idle")

func hero_direction():
	if hero.position.x < position.x:
		hero_position = -1
	else:
		hero_position = 1

func player_muzzle_position():
	if hero_position > 0:
		enemy.flip_h = false
		muzzle.position.x = muzzle_position.x
	elif hero_position < 0:
		enemy.flip_h = true
		muzzle.position.x = -muzzle_position.x

func _on_Timer_timeout():
	can_walk = true


func _on_Hurtbox_area_entered(area : Area2D):
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health ", health_amount)
		set_health_bar()
		
		if health_amount <= 0:
			enemy.play("death")
			death = true
			$AnimatedSprite/DeathTimer.start()


func _on_DeathTimer_timeout():
	death = false
	queue_free()

func player_entered():
	can_shoot = true

func player_exited():
	can_shoot = false



func _on_ShooterTimer_timeout():
	shoot = true
	$ShooterTimer.start()
	


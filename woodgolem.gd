extends KinematicBody2D

export(NodePath) var Hero
onready var hero = get_node(Hero)

export(int) var speed = 100
export(int) var HEALTH : int = 10
export(int) var damage_amount = 1

onready var wood_golem = $AnimatedSprite
enum state {Idle, Attack, Run, Death}
# Declare member variables here.
const GRAVITY : int = 20 
var health_amount : int
var motion : Vector2 = Vector2()
var current_state : int
var hero_position : int
var death : bool
var hero_entered : bool


# Called when the node enters the scene tree for the first time.
func _ready():
	current_state = state.Idle
	if hero == null:
		print("No hero assigned")
	death = false
	hero_entered = false
	health_amount = HEALTH
	$HealthBar.max_value = HEALTH
	$HealthBar.value = health_amount

func _physics_process(delta):
	motion.y += GRAVITY + delta
	hero_direction()
	match current_state:
		state.Idle:
			idle()
		state.Attack:
			attack()
		state.Run:
			run(delta)
		state.Death:
			death()
		_:
			print("Not valid state")
	
	motion = move_and_slide(motion)

func idle():
	wood_golem.play("Idle")
	motion.x = 0

func attack():
	motion.x = 0
	wood_golem.play("Attack")

func run(delta):
	hero_direction()
	var direction = hero_position
	wood_golem.play("Run")
	motion.x = direction * speed + delta
	if hero.position.y < (position.y - 11):
		idle()
	else:
		wood_golem.flip_h = direction > 0


func death():
	wood_golem.play("Death")
	motion.x = 0


func get_damage_amount():
	return damage_amount
	

func set_health_bar():
	$HealthBar.value = health_amount

func _on_Detector_area_entered(area):
	if !death:
		current_state = state.Run


func _on_Detector_area_exited(area):
	if !area.is_in_group("bullet"):
		if !death:
			current_state = state.Idle

func hero_direction():
	if hero.position.x < position.x:
		hero_position = -1
	else:
		hero_position = 1


func _on_Hurtbox_area_entered(area : Area2D):
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health ", health_amount)
		set_health_bar()
		
		if health_amount == 0:
			death = true
			current_state = state.Death
			$DeathTimer.start()


func _on_DeathTimer_timeout():
	queue_free()
	death = false


func _on_AttackDetector_area_entered(area):
	print("Attacker area entered")
	if !death:
		if area.is_in_group("hero"):
			hero_entered = true
			current_state = state.Attack
			#reduce player health
		if hero_entered:
				$AttackDetector/AttackTimer.start()

func _on_AttackDetector_area_exited(area):
	if !death:
		if area.is_in_group("hero"):
			hero_entered = false
			current_state = state.Run
			$AttackDetector/AttackTimer.stop()
		else:
			if !hero_entered:
				current_state = state.Run
			else:
				current_state = state.Attack




func _on_AttackTimer_timeout():
	print("hero health ", hero.health_amount)
	hero.health_amount -= damage_amount
	hero.set_health_bar()

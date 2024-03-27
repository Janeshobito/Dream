extends AnimatedSprite

export(int) var damage_amount = 1
# Declare member variables here. Examples:
var speed : int = 600
var direction : int


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	move_local_x(direction * speed * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func bullet_impact():
	queue_free()
	

func get_damage_amount():
	return damage_amount

func _on_Hitbox_area_entered(area):
	#print("Enemy Bullet area entered")
	bullet_impact()


func _on_Hitbox_body_entered(body):
	#print("Enemy Bullet body entered")
	bullet_impact()

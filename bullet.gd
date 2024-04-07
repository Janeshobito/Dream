extends AnimatedSprite

var  bullet_impact_effect = preload("res://BulletImpactEffect.tscn")
export(int) var damage_amount = 2

var speed : int = 600
var direction : int



func _physics_process(delta):
	move_local_x(direction * speed * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()



func _on_Hitbox_area_entered(area):
	print("area detected")
	if !area.is_in_group("Detector"):
		bullet_impact()


func _on_Hitbox_body_entered(body):
	print("body detected")
	bullet_impact()
	
func get_damage_amount() -> int:
	return damage_amount

func bullet_impact():
	var bullet_impact_effect_instance = bullet_impact_effect.instance() as Node2D
	bullet_impact_effect_instance.global_position = global_position
	get_parent().add_child(bullet_impact_effect_instance)
	queue_free()


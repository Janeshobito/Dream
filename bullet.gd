extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed : int = 600
var direction : int



func _physics_process(delta):
	move_local_x(direction * speed * delta)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()

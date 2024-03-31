extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	play("Open")
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	if animation == "Open":
		play("Idle")
	else:
		queue_free()


func _on_Area2D_area_exited(area):
	play("Close")
	$Timer.start()

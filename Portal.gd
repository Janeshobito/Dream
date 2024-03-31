extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var Enemies
onready var enemies = get_node(Enemies)

onready var portal = $AnimatedSprite
export(int) var level_count : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	portal.play("Idle")
	level_count += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if enemies.get_child_count() == 0:
		modulate = Color( 1, 1, 1, 1 )


func _on_Portal_area_entered(area):
	if enemies.get_child_count() == 0:
		if area.is_in_group("hero"):
			$Timer.start()
			portal.play("Close")
			area.get_parent().visible = false


func _on_Timer_timeout():
		get_tree().change_scene("res://TransitionScene.tscn")

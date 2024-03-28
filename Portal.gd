extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var portal = $AnimatedSprite
export(int) var level_count : int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	portal.play("Idle")
	level_count += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Portal_area_entered(area):
	if area.is_in_group("hero"):
		if level_count == 2:
			get_tree().change_scene("res://level2.tscn")
		elif level_count == 3:
			get_tree().change_scene("res://level3.tscn")
		elif level_count == 4:
			get_tree().change_scene("res://level4.tscn")
		elif level_count == 5:
			get_tree().change_scene("res://level6.tscn")
		else:
			print("You win the game")

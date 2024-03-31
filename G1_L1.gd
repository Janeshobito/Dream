extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if !get_child(0).is_in_group("G1"):
		queue_free()
	
func _on_DetectorG1_area_entered(area):
	print("DetectorG1")
	get_tree().call_group("G1", "player_entered")
	get_tree().call_group("G1", "shoot")

func _on_DetectorG1_area_exited(area):
	if !area.is_in_group("bullet"):
		get_tree().call_group("G1", "player_exited")


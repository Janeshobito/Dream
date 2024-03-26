extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# G1 group begin
func _on_DetectorG1_area_entered(area):
	print("DetectorG1")
	get_tree().call_group("G1", "player_entered")
	get_tree().call_group("G1", "shoot")

func _on_DetectorG1_area_exited(area):
	get_tree().call_group("G1", "player_exited")
#G1 group end

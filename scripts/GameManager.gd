extends Node

#var level1 = preload("res://level1.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level_count : int
var Level : String
var Point : int
# Called when the node enters the scene tree for the first time.
func _ready():
	level_count = 0 #For changing level and UI level_name
	Point = 0 #For UI points
	Level = "[center]LEVEL " #For changing level name.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

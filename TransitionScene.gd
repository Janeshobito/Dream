extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level_number : String # For storing level number in string
var level : String # For storing level path
# Called when the node enters the scene tree for the first time.
func _ready():
	level = "res://level%s.tscn"
	GameManager.level_count += 1
	level_number = str(GameManager.level_count) # convert level_count interger to string
	level = level % level_number # level path
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	get_tree().change_scene(level)

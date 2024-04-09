extends CanvasLayer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(NodePath) var Hero
onready var hero = get_node(Hero)
onready var health = $HBoxContainer/health_amount
onready var level = $level
onready var points = $HBoxContainer/points_amount
var Health : int

# Called when the node enters the scene tree for the first time.
func _ready():
	Health = hero.Health
	level.bbcode_text = GameManager.Level + str(GameManager.level_count)
	health.bbcode_text = str(calcPercentage(hero.health_amount, Health))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	health.bbcode_text = str(calcPercentage(hero.health_amount, Health))
	points.bbcode_text = str(GameManager.Point)

func calcPercentage(partialValue, totalValue):
	return int((float(partialValue) / totalValue) * 100)


extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$moedas.text = str(Global.moeda)
	$modo.text = str(Global.modo)
	$vida.text = str(get_parent().vida)
#	pass

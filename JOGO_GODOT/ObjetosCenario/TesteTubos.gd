extends Spatial
var bot1 = false
var bot2 = true
var passe = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_node("Porta3").passe = false

func time():
	$Timer.start()
	yield($Timer, "timeout")
	if bot1 == false or bot2 == false:
		bot1 = false
		bot2 = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if passe == true:
		get_parent().get_node("Porta3").passe = true
#	pass


func _on_Area_body_entered(body):
	print("jdjdjdjdjdjdjdjdjdjjdjddjdjdjjddj")
	if body.is_in_group("bt12"):
		print("1")
		bot1 = true
		time()
		if bot2 == true:
			print("1111")
			passe = true

func _on_Area2_body_entered(body):
	print("jdjdjdjdjdjdjdjdjdjjdjddjdjdjjddj")
	if body.is_in_group("bt12"):
		print("1")
		bot2 = true
		time()
		if bot1 == true:
			print("1111")
			passe = true

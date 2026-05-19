extends Node
var moeda = 0
var modo = 1
var habilidades = 2
var player
var dialogando = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func sound(quem, som):
	var sound = preload("res://sons/sound.tscn").instance()
	sound.transform.origin = quem.transform.origin
	sound.stream = load(som)
	quem.get_parent().add_child(sound)
	sound.play()
	print("opa")
	

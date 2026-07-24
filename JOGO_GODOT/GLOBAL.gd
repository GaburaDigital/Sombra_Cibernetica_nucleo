extends Node
var moeda = 0
var modo = 1
var habilidades = 2
var player
var dialogando = false

var volume = 0
var musica = 0
var sensibilidade = 1
var telacheia = false
var brilho = 100

var bt12 = true
var menu = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if telacheia == true:
		OS.window_fullscreen = true
	else:
		OS.window_fullscreen = false
	
	if $musica.playing == false and menu == true:
		$musica.play()
	
	if $musica.playing == true and menu == false:
		$musica.stop()
		
	$musica.volume_db = musica
	
func sound(quem, som):
	var sound = preload("res://sons/sound.tscn").instance()
	sound.transform.origin = quem.transform.origin
	sound.stream = load(som)
	sound.unit_db = volume
	quem.get_parent().add_child(sound)
	sound.play()
	#print("opa")
	

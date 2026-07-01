extends Spatial
var aberto1
var aberto2
export(int) var andar1
export(int) var andar2
export(bool) var pisofalso = false
var alternando = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$lado1.number = andar1
	$lado2.number = andar2
	if pisofalso == true:
		$CSGBox.queue_free()
	pass # Replace with function body.

func andar():
	if alternando == false:
		if aberto1 == true:
			$lado1.interact()
			
		if aberto2 == true:
			$lado2.interact()
		alternando = true
		yield(get_tree().create_timer(5), "timeout")
		
		if get_parent().get_parent().andar == andar1:
			get_parent().get_parent().andar = andar2
		else:
			get_parent().get_parent().andar = andar1
		alternando = false
		$aud.play()
		$lado1.interact()
		$lado2.interact()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	aberto1 = $lado1.aberto
	aberto2 = $lado2.aberto
#	pass

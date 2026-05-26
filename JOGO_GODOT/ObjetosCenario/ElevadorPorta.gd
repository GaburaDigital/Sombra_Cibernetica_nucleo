extends CSGCombiner
var aberto = false
var dad
var number
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	dad = get_parent()
	pass # Replace with function body.
func alternar():
	if dad.alternando == false:
		if aberto == true:
			aberto = false
			$anim.play("fechar")
		else:
			if dad.get_parent().andar == number:
				aberto = true
				$anim.play("abrir")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

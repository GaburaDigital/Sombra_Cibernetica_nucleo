extends Spatial
var aberto = false
var passe = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	if passe == true:
		if aberto == true:
			aberto = false
			$lado1/anim.play("fechar")
		else:
			aberto = true
			$lado1/anim.play("abrir")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if passe == true:
		$lado1/x.visible = false
	else:
		$lado1/x.visible = true

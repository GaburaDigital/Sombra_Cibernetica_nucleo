extends Spatial
var aberto = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("bt12"):
		if aberto == true:
			$lado1/anim.play("fechar")
			$Botao/aud.play()
			aberto = false
		else:
			$lado1/anim.play("abrir")
			$Botao/aud.play()
			aberto = true
		

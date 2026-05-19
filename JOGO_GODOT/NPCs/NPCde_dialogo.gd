extends KinematicBody
var velocidade = Vector3()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func dialogue():
	Global.player.emit_signal("dialogo", ["six seven","oba oba oba"], self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	velocidade.y -= 8.6 * delta
	velocidade = move_and_slide(velocidade, Vector3.UP)
	

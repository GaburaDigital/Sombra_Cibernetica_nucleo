extends KinematicBody
var dano = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not position.y <= 1:
		position.y -= 5 * delta
	else:
		dano = false
		
#	pass


func _on_Area_body_entered(body):
	if dano == true and body.is_in_group("player"):
		body.vida -= 2
		dano = false

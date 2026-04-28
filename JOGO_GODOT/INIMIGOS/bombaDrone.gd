extends RigidBody
var dano = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if translation.y < -5:
		queue_free()
#	pass


func _on_Area_body_entered(body):
	if not body.is_in_group("inimigo"):
		queue_free()
	if body.is_in_group("player"):
		body.vida -= 1
		queue_free()

extends Spatial
var andar = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Inimigos.queue_free()
	$AudioStreamPlayer.play()
	$Fabrica/teto.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AudioStreamPlayer.volume_db = Global.musica
#	pass

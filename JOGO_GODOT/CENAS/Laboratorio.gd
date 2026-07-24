extends Spatial
var andar = 1
var win = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.menu = false
	$AudioStreamPlayer.play()
	$Fabrica/teto.visible = true
	pass # Replace with function body.

func winin():
	yield(get_tree().create_timer(2,5), "timeout")
	get_tree().change_scene("res://CENAS/historia.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AudioStreamPlayer.volume_db = Global.musica
	if win == true:
		winin()
		win = false

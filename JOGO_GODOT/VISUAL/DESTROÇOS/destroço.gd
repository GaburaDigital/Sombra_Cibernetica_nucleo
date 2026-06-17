extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var a = [1, 2].pick_random()
	if a == 2:
		$PORCA_ANIME.visible = true
	else:
		$PREGO_ANIME.visible = true
	yield(get_tree().create_timer((rand_range(4, 6))), "timeout")
	queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	
#	pass

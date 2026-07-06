extends Spatial
export(int) var distance = 20
export(bool) var fisico = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.player != null:
		var distancia = global_position.distance_to(Global.player.global_position)
		if fisico == true:
			if distancia > distance and get_parent().is_physics_processing():
				get_parent().set_physics_process(false)
			
			elif distancia < distance and not get_parent().is_physics_processing():
				get_parent().set_physics_process(true)
		else:
			if distancia > distance and get_parent().is_processing():
				get_parent().set_process(false)
			
			elif distancia < distance and not get_parent().is_processing():
				get_parent().set_process(true)

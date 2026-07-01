extends Spatial


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
		if distancia > 20 and get_parent().is_physics_processing():
			get_parent().set_physics_process(false)
			print("desliguei kk")
		
		elif distancia < 20 and not get_parent().is_physics_processing():
			get_parent().set_physics_process(true)

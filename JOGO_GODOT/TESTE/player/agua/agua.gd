extends RigidBody
var dano = 1

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var mat = $CSGSphere.material
	mat.albedo_color = Color(1, 1, 1, 0.9)
	mat.flags_transparent = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if translation.y < -5:
		queue_free()
#	pass


func _on_Area_body_entered(body):
	if body.is_in_group("inimigo"):
		body.vida -= 1
		var res = preload("res://VISUAL/respingo.tscn").instance()
		res.global_position = global_position
		res.emitting = true
		get_parent().add_child(res)
		queue_free()
		
	if not body.is_in_group("player"):
		var res = preload("res://VISUAL/respingo.tscn").instance()
		res.global_position = global_position
		res.emitting = true
		get_parent().add_child(res)
		queue_free()

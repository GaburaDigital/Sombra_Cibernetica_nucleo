extends KinematicBody
var velocidade = Vector3()
var player
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player = get_tree().get_nodes_in_group("player")[0]
	$Position3D.global_transform.origin.z = player.transform.origin.z
	$Position3D.global_transform.origin.x = player.transform.origin.x
	$Position3D.global_transform.origin.y = transform.origin.y
	
	if Global.modo == 2:
		$col.disabled = false
		$camera/camera.current = true
		velocidade.x = lerp(velocidade.x, 0, 0.1)
		velocidade.z = lerp(velocidade.z, 0, 0.1)
	
		if Input.is_action_pressed("ui_left"):
			rotate_y(2 * delta)
			
		if Input.is_action_pressed("ui_right"):
			rotate_y(-2 * delta)
			
		if Input.is_action_pressed("ui_up"):
			var frente = -transform.basis.z
			velocidade.x += frente.x * 50 * delta
			velocidade.z += frente.z * 50 * delta
			
		if Input.is_action_pressed("ui_down"):
			var frente = transform.basis.z
			velocidade.x += frente.x * 50 * delta
			velocidade.z += frente.z * 50 * delta
		if Input.is_action_just_pressed("ui_select"):
			pass
			
	else:
		look_at($Position3D.global_transform.origin, Vector3.UP)
		transform.origin.z = lerp(transform.origin.z, player.transform.origin.z, 0.1)
		transform.origin.x = lerp(transform.origin.x, player.transform.origin.x, 0.1)
		$col.disabled = true
		$camera/camera.current = false
	
	velocidade = move_and_slide(velocidade, Vector3.UP)
		#velocidade.x -= 50 * delta

	

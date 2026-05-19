extends KinematicBody
var velocidade = Vector3()
var player
var pos
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player = get_tree().get_nodes_in_group("player")[0]
	pos = player.get_node("pos")
#	$Position3D.global_transform.origin.z = player.transform.origin.z
#	$Position3D.global_transform.origin.x = player.transform.origin.x
#	$Position3D.global_transform.origin.y = transform.origin.y
	
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
			
		if Input.is_action_pressed("ui_baixo"):
			transform.origin.y -= 1 * delta
			
		if Input.is_action_pressed("ui_cima"):
			transform.origin.y += 1 * delta
				
		if Input.is_action_just_pressed("ui_select"):
			pass
			
	else:
		
		var truepos = pos.global_transform.origin
		
		if player.movendo == false:
			if abs(transform.origin.z - truepos.z) < 0.2:
				transform.origin.z = truepos.z
			if abs(transform.origin.x - truepos.x) < 0.2:
				transform.origin.x = truepos.x
		
		truepos.y = transform.origin.y
		if not global_transform.origin == truepos:
			look_at(truepos, Vector3.UP)
			transform.origin.z = lerp(transform.origin.z, pos.global_transform.origin.z, 0.1)
			transform.origin.x = lerp(transform.origin.x, pos.global_transform.origin.x, 0.1)
			transform.origin.y = lerp(transform.origin.y, pos.global_transform.origin.y, 0.1)
		else:
			rotate_y(1 * delta)
		$col.disabled = true
		$camera/camera.current = false
	
	velocidade = move_and_slide(velocidade, Vector3.UP)
		#velocidade.x -= 50 * delta

	

extends KinematicBody
var velocidade = Vector3()
var player
var pos
var modo
var enemies = []
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	modo = Global.modo
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	player = get_tree().get_nodes_in_group("player")[0]
	pos = player.get_node("pos")
#	$Position3D.global_transform.origin.z = player.transform.origin.z
#	$Position3D.global_transform.origin.x = player.transform.origin.x
#	$Position3D.global_transform.origin.y = transform.origin.y
	
	$droneSom.unit_db = Global.volume
	$audio.unit_db = Global.volume
	$audio2.unit_db = Global.volume
	
	if Global.modo == 2:
	
		if modo != 2:
			$audio.play()
			for inimigo in get_tree().get_nodes_in_group("inimigo"):
				if not inimigo.is_in_group("boss"):
					inimigo.set_physics_process(false)
					inimigo.get_node("otimiz").set_process(false)
					enemies.append(inimigo)
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
			velocidade.x = frente.x * 150 * delta
			velocidade.z = frente.z * 150 * delta
			
		if Input.is_action_pressed("ui_down"):
			var frente = transform.basis.z
			velocidade.x = frente.x * 150 * delta
			velocidade.z = frente.z * 150 * delta
			
		if Input.is_action_pressed("ui_baixo"):
			transform.origin.y += 1 * delta
			
		if Input.is_action_pressed("ui_cima"):
			transform.origin.y -= 1 * delta
		
			
		
		if Input.is_action_just_pressed("ui_select"):
			pass
			
	else:
		if modo == 2:
			$audio2.play()
			for inim in enemies:
				if is_instance_valid(inim):
					inim.set_physics_process(true)
					inim.get_node("otimiz").set_process(true)
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
#			var frente = -transform.basis.z
#			velocidade.x = frente.x * 150 * delta
#			velocidade.z = frente.z * 150 * delta
			
		else:
			rotate_y(1 * delta)
			transform.origin.y = lerp(transform.origin.y, pos.global_transform.origin.y, 0.1)
		$col.disabled = true
		$camera/camera.current = false
		if Global.bt12 == false:
			queue_free()
	modo = Global.modo
	velocidade.y = 0
	velocidade = move_and_slide(velocidade, Vector3.UP)
		#velocidade.x -= 50 * delta
	
	

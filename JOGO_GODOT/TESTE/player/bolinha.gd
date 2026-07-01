extends KinematicBody
var velocidade = Vector3()
var vida = 7
var mun = 4
var velo = 150
const munmax = 4
var muncont = 1
var movendo = false
var modo = Global.modo
signal dialogo(frase, npc)
var drones = []
var move = ["p", false]
var impact = false
# modos:
# 1. agua
# 2. drone


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Global.player = self
	
	pass # Replace with function body.

func agua():
	var agua = preload("res://TESTE/player/agua/agua.tscn").instance()
	agua.linear_velocity = -transform.basis.z * 20
	agua.global_transform.origin = $disparo.global_transform.origin
	#agua.transform.origin.y += 1
	#agua.linear_velocity.y += 2
	Global.sound(self, "res://sons/blowing-bubbles-in-a-mug.mp3")
	get_parent().add_child(agua)
	
func anim():
	pass
func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_teste"):
		$ARMA_ELETRICA_ANIME.get_node("AnimationPlayer").play_backwards("arma r saindo")
		
	velocidade.x = lerp(velocidade.x, 0, 0.1)
	velocidade.z = lerp(velocidade.z, 0, 0.1)
	
	if abs(velocidade.x) < 0.2:
		velocidade.x = 0 
	if abs(velocidade.z) < 0.2:
		velocidade.z = 0 
		
	if velocidade.x == 0 and velocidade.z == 0:
		movendo = false
	else:
		movendo = true
		
	
	
	velocidade.y -= 8.6 * delta
	if Global.modo != 2 and impact == false:
		if Input.is_action_pressed("ui_left"):
			rotate_y(1 * delta)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("para esquerda2", 0.1)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda M").rotate_x(1.5 * delta)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda G2").rotate_x(-1.5 * delta)
#			if move[0] != "d":
#				move[1] = false
#				move[0] = "d"
#				$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("reacao esquerda", 2)
#				yield($MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer"), "animation_finished")
#				move[1] = true
#			elif move[1] == true:
#				$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("para esquerda2", 2)
			movendo = true
			
		if Input.is_action_pressed("ui_right"):
			rotate_y(-1 * delta)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("para direita", 0.1)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda M").rotate_x(-1.5 * delta)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda G2").rotate_x(1.5 * delta)
#			if move[0] != "e":
#				move[1] = false
#				move[0] = "e"
#				$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("reacao direita", 2)
#				yield($MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer"), "animation_finished")
#				move[1] = true
#			elif move[1] == true:
#				$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("para direita", 2)
			movendo = true
			
		if Input.is_action_pressed("ui_up"):
			var frente = -transform.basis.z
			velocidade.x = frente.x * velo * delta
			velocidade.z = frente.z * velo * delta
			$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("para frente2", 0.1)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda M").rotate_x(1.5 * delta)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda G2").rotate_x(1.5 * delta)
			#$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("para frente2")
			
		if Input.is_action_pressed("ui_down"):
			var frente = transform.basis.z
			velocidade.x = frente.x * velo * delta
			velocidade.z = frente.z * velo * delta
			$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("para tras", 0.1)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda M").rotate_x(-1.5 * delta)
			$MIRO_ANIME.get_node("cadeira - Miro (1)/Node2/Gato na Cadeira/cadeira/base2/roda G2").rotate_x(-1.5 * delta)
			
		if Input.is_action_just_pressed("ui_select"):
			if Global.modo == 1 and mun != 0:
				agua()
				mun -= 1
				muncont = 0
		if Input.is_action_pressed("ui_select") and Global.modo == 3:
			$PlayerUI/ProgressBar.scale.x += 1 * delta
			if $PlayerUI/ProgressBar.scale.x >= 4:
				$PlayerUI/ProgressBar.scale.x = 0
				$shock.play()
				if drones.size() > 0:
					$shock2.emitting = true
					
					var drone = drones[0]
					$shock2.look_at(drone.global_position, Vector3.UP)
					drone.vida -= 1
					yield(get_tree().create_timer(delta), "timeout")
					if drone == null:
						drones.erase(drone)
					
	$energ.radius = $PlayerUI/ProgressBar.scale.x / 10
	if movendo == false:
		$MIRO_ANIME.get_node("cadeira - Miro (1)/AnimationPlayer").play("Idle 1", 0.1)
		move[0] = "p"
		move[1] = false
	if not Input.is_action_pressed("ui_select") or not Global.modo == 3:
		if $PlayerUI/ProgressBar.scale.x > 0:
			$PlayerUI/ProgressBar.scale.x -= 1 * delta
		else:
			$PlayerUI/ProgressBar.scale.x = 0
		
		
			
	if Global.modo == 3:
		
		$PlayerUI/BarraAgua.visible = false
		$PlayerUI/barra3.visible = false
		$PlayerUI/agua.visible = false
		
		$PlayerUI/ProgressBar.visible = true
		$PlayerUI/barra4.visible = true
		$PlayerUI/agua2.visible = true
	elif Global.modo == 1:
		
		$PlayerUI/BarraAgua.visible = true
		$PlayerUI/barra3.visible = true
		$PlayerUI/agua.visible = true
		
		$PlayerUI/ProgressBar.visible = false
		$PlayerUI/barra4.visible = false
		$PlayerUI/agua2.visible = false
		
	else:
		
		$PlayerUI/BarraAgua.visible = false
		$PlayerUI/barra3.visible = false
		$PlayerUI/agua.visible = false
		
		$PlayerUI/ProgressBar.visible = false
		$PlayerUI/barra4.visible = false
		$PlayerUI/agua2.visible = false
	if Input.is_action_just_pressed("ui_accept"):
		if not Global.modo > Global.habilidades:
			if Global.modo == 1:
				Global.sound(self, "res://sons/bt-12_acordando.mp3")
				$ARMA_AGUA_ANIME.get_node("AnimationPlayer").play("arma saindo")
			elif Global.modo == 2:
				$ARMA_ELETRICA_ANIME.get_node("AnimationPlayer").play_backwards("arma r saindo")
			Global.modo += 1
			
		else:
			$ARMA_AGUA_ANIME.get_node("AnimationPlayer").play_backwards("arma saindo")
			$ARMA_ELETRICA_ANIME.get_node("AnimationPlayer").play("arma r saindo")
			Global.modo = 1
		
	if not mun == munmax:
		if muncont >= 1:
			mun += 1
			muncont = 0
			
	if not muncont >= 1:
		muncont += delta
	
	var colide = $frente.get_collider()
	if $frente.is_colliding() and colide.is_in_group("interact"):
		$Sprite3D.visible = true
	else:
		$Sprite3D.visible = false
		
		
	if Input.is_action_just_pressed("ui_home"):
		if $frente.is_colliding():
			print("ola!")
			
			if colide.is_in_group("interact"):
				colide.interact()
			
				
		
	
	
	if Global.modo == 2:
			$camera/camera.current = false
	else:
		if modo == 2:
			$camera/camera.current = true
	modo = Global.modo
	
	if vida <= 0:
		Global.player = null
		for inimigo in get_tree().get_nodes_in_group("inimigo"):
			inimigo.set_physics_process(false)
		get_tree().get_nodes_in_group("bt12")[0].set_physics_process(false)
		$PlayerUI.morte()
		var cam = $camera
		var ui = $PlayerUI
		var camP = $camera.global_transform
		var fum = $CPUParticles
		var fumP = $CPUParticles.global_transform
		remove_child($camera)
		remove_child($PlayerUI)
		remove_child($CPUParticles)
		get_parent().add_child(fum)
		get_parent().add_child(ui)
		get_parent().add_child(cam)
		fum.global_transform = fumP
		fum.emitting = true
		cam.global_transform = camP
		
		queue_free()
		
		
	velocidade = move_and_slide(velocidade, Vector3.UP)




func _on_Area_body_entered(body):
	if body.is_in_group("drone") and body.is_in_group("inimigo"):
		drones.append(body)
	pass
func _on_Area_body_exited(body):
	if body in drones:
		drones.erase(body)

extends KinematicBody
var velocidade = Vector3()
var vida = 8
var mun = 4
const munmax = 4
var muncont = 1
var movendo = false
var modo = Global.modo
signal dialogo(frase, npc)
# modos:
# 1. agua
# 2. drone


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player = self
	
	pass # Replace with function body.

func agua():
	var agua = preload("res://TESTE/player/agua/agua.tscn").instance()
	agua.linear_velocity = -transform.basis.z * 20
	agua.transform.origin = transform.origin
	#agua.transform.origin.y += 1
	agua.linear_velocity.y += 2
	Global.sound(self, "res://sons/blowing-bubbles-in-a-mug.mp3")
	get_parent().add_child(agua)
	

func _physics_process(delta):
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
	if Global.modo != 2:
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
			if Global.modo == 1 and mun != 0:
				agua()
				mun -= 1
				muncont = 0
	if Input.is_action_just_pressed("ui_accept"):
		if not Global.modo > Global.habilidades:
			if Global.modo == 1:
				Global.sound(self, "res://sons/bt-12_acordando.mp3")
			Global.modo += 1
		else:
			Global.modo = 1

	if not mun == munmax:
		if muncont >= 1:
			mun += 1
			muncont = 0
			
	if not muncont >= 1:
		muncont += delta
		
	if Input.is_action_just_pressed("ui_home"):
		if $frente.is_colliding():
			print("ola!")
			var colide = $frente.get_collider()
			if colide.is_in_group("dialogue"):
				colide.dialogue()
				
		
	
	
	if Global.modo == 2:
			$camera/camera.current = false
	else:
		if modo == 2:
			$camera/camera.current = true
	modo = Global.modo
	velocidade = move_and_slide(velocidade, Vector3.UP)
	
	


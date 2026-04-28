extends KinematicBody
var velocidade = Vector3()
var entrou = false
var player = null
var PodeAtacar = false
var atento = false
var ataque = 5
var visao = Vector3()
var vidaAntiga 
var guarda

export var dano = 1
export var vidaMax = 3
export var velo = 15
var contador = 0

var vida
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	vida = vidaMax
	vidaAntiga = vida
	$Area.set_as_toplevel(true)
	guarda = $Position3D.global_transform.origin
	
func atacar():
	var bomba = preload("res://INIMIGOS/bombaDrone.tscn").instance()
	bomba.global_transform.origin = global_transform.origin
	get_parent().add_child(bomba)
	
func _physics_process(delta):
	if player != null:
		visao = Vector3(player.transform.origin.x, transform.origin.y, player.transform.origin.z)
	else:
		player = get_tree().get_nodes_in_group("player")[0]
	velocidade.x = lerp(velocidade.x, 0, 0.1)
	velocidade.z = lerp(velocidade.z, 0, 0.1)
	
	
	
	if entrou == true:
		look_at(visao, Vector3.UP)
		var frente = -transform.basis.z
		velocidade.x += frente.x * velo * delta
		velocidade.z += frente.z * velo * delta
	else:
		if global_transform.origin != guarda:
			look_at(guarda, Vector3.UP)
		else:
			rotate_y(2 * delta)
		transform.origin.z = lerp(transform.origin.z, guarda.z, 0.1)
		transform.origin.x = lerp(transform.origin.x, guarda.x, 0.1)
		
		if abs(transform.origin.z - guarda.z) < 0.2:
			transform.origin.z = guarda.z
		if abs(transform.origin.x - guarda.x) < 0.2:
			transform.origin.x = guarda.x
		

		
	if  $RayCast.is_colliding() and  $RayCast.get_collider().is_in_group("player"):
		if contador >= 2:
			contador = 0
			
		else:
			contador += delta
			return
		
		
		
	
	if vida <= 0:
		for i in range(20):
			var pedaso = preload("res://VISUAL/DESTROÇOS/destroço.tscn").instance()
			pedaso.global_transform.origin = transform.origin
			pedaso.linear_velocity.x = (rand_range(-1, 1)) * 25
			pedaso.linear_velocity.z = (rand_range(-1, 1)) * 25
			pedaso.linear_velocity.y = (rand_range(-1, 1)) * 25
			get_parent().add_child(pedaso)
		queue_free()
	
	velocidade = move_and_slide(velocidade, Vector3.UP)


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		entrou = true # Replace with function body.
		if atento == false: 
			$alerta.play()
		
func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		entrou = false

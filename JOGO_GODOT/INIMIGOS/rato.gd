extends KinematicBody
var velocidade = Vector3()
var entrou = false
var player = null
var PodeAtacar = false
var atento = false
var ataque = 5
var visao = Vector3()
var vidaAntiga 

export var dano = 1
export var vidaMax = 3

var vida
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	vida = vidaMax
	vidaAntiga = vida


func _physics_process(delta):
	if player != null:
		visao = Vector3(player.transform.origin.x, transform.origin.y, player.transform.origin.z)
	else:
		player = get_tree().get_nodes_in_group("player")[0]
	velocidade.x = lerp(velocidade.x, 0, 0.1)
	velocidade.z = lerp(velocidade.z, 0, 0.1)
	
	velocidade.y -= 8.6 * delta
	
	
	
	if entrou == true:
		look_at(visao, Vector3.UP)
		atento = true
		
	if vida != vidaAntiga:
		print("aii!")
		look_at(visao, Vector3.UP)
		atento = true
		
	vidaAntiga = vida
		
	if  $RayCast.is_colliding() and not $RayCast.get_collider().is_in_group("player"):
		atento = false
		
		
	elif ($RayCast.is_colliding() and $RayCast.get_collider().is_in_group("player")) and atento == true:
		look_at(visao, Vector3.UP)
		var frente = -transform.basis.z
		velocidade.x += frente.x * 15 * delta
		velocidade.z += frente.z * 15 * delta
		
	elif not $RayCast.is_colliding() and atento == true:
		var frente = -transform.basis.z
		velocidade.x += frente.x * 15 * delta
		velocidade.z += frente.z * 15 * delta
	
	if PodeAtacar == true and ataque > 1.5:
		for corpo in $AreaAbate.get_overlapping_bodies():
			if corpo.is_in_group("player"):
				corpo.vida -= dano
				ataque = 0
	else:
		if ataque <= 1.5:
			ataque += delta
	
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

func _on_AreaAbate_body_entered(body):
	if body.is_in_group("player"):
		PodeAtacar = true

func _on_AreaAbate_body_exited(body):
	if body.is_in_group("player"):
		PodeAtacar = false

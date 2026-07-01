extends KinematicBody
var velocidade = Vector3()
var entrou = false
var player = null
var PodeAtacar = false
var atento = false
var ataque = 5
var visao = Vector3()
var vidaAntiga 
var impact = 0
var Pimpact = 0
var desimpact = false
var movendo = false

export var dano = 1
export var vidaMax = 3
export var velo = 150

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
	
	if abs(velocidade.x) < 0.2:
		velocidade.x = 0 
	if abs(velocidade.z) < 0.2:
		velocidade.z = 0 
		
	if velocidade.x == 0 and velocidade.z == 0:
		movendo = false
	else:
		movendo = true
		
	if entrou == true:
		look_at(visao, Vector3.UP)
		atento = true
		
	if vida != vidaAntiga:
		print("aii!")
		look_at(visao, Vector3.UP)
		atento = true
		
	vidaAntiga = vida
	
	if movendo == true:
		$RATO.get_node("AnimationPlayer").play("frente", 0.1)
	else:
		$RATO.get_node("AnimationPlayer").play("idle", 0.1)
	
	if  $RayCast.is_colliding() and not $RayCast.get_collider().is_in_group("player"):
		atento = false
		
		
	elif ($RayCast.is_colliding() and $RayCast.get_collider().is_in_group("player")) and atento == true:
		look_at(visao, Vector3.UP)
		var frente = -transform.basis.z
		velocidade.x = frente.x * velo * delta
		velocidade.z = frente.z * velo * delta
		
	elif not $RayCast.is_colliding() and atento == true:
		var frente = -transform.basis.z
		velocidade.x = frente.x * velo * delta
		velocidade.z = frente.z * velo * delta
	
	if PodeAtacar == true and ataque > 1.5:
		for corpo in $AreaAbate.get_overlapping_bodies():
			if corpo.is_in_group("player"):
				corpo.vida -= dano
				ataque = 0
				impact = 0.5 / delta
				velocidade.y += 1
				Pimpact = 0.5 / delta
				player.velocidade.y += 1
				var particula = preload("res://VISUAL/faisca.tscn").instance()
				particula.global_transform = $faisca.global_transform
				particula.emitting = true
				get_parent().add_child(particula)
				$hit.play()
	else:
		if ataque <= 1.5:
			ataque += delta
	
	if vida <= 0:
		for i in range(80):
			var pedaso = preload("res://VISUAL/DESTROÇOS/destroço.tscn").instance()
			pedaso.transform.origin = transform.origin
			pedaso.linear_velocity.x = (rand_range(-1, 1)) * 10
			pedaso.linear_velocity.z = (rand_range(-1, 1)) * 10
			pedaso.linear_velocity.y = (rand_range(-1, 1)) * 10
			get_parent().add_child(pedaso)
		Global.sound(self, "res://sons/explosao de derrota_robõ_rato_spada.mp3")
		var moeda = preload("res://COLETAVEIS/Moeda.tscn").instance()
		moeda.transform.origin = transform.origin
		moeda.transform.origin.y = 1.397
		get_parent().add_child(moeda)
		queue_free()
	if impact > 0:
		impact -= 1
		var frente = transform.basis.z
		velocidade.x = frente.x * 200 * delta
		velocidade.z = frente.z * 200 * delta
		
	if Pimpact > 0:
		Pimpact -= 1
		var frente = -transform.basis.z
		player.velocidade.x = frente.x * 200 * delta
		player.velocidade.z = frente.z * 200 * delta
		player.impact = true
		desimpact = true
	else:
		if desimpact == true:
			player.impact = false
			desimpact = false
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

extends KinematicBody
var fase = 1

var vida = 20

var ataques = ["varredura", "laserx", "laserx2"]
var area = false
var varedura = false
var coldou = 0

var laser = false
var atacando = false
var Pimpact = 0
var bal = false

onready var player = get_tree().get_nodes_in_group("player")[0]

var ativo = false
var gira = false
var desimpact = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var laser1 = get_parent().get_node("laser1")
onready var laser2 = get_parent().get_node("laser2")

signal laserEnd
signal hit
signal bal

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	
func escolha():
	
	if vida <= 0 and fase == 1:
		for i in range(80):
			var pedaso = preload("res://VISUAL/DESTROÇOS/destroço.tscn").instance()
			pedaso.transform.origin = transform.origin
			pedaso.linear_velocity.x = (rand_range(-1, 1)) * 50
			pedaso.linear_velocity.z = (rand_range(-1, 1)) * 50
			pedaso.linear_velocity.y = (rand_range(-1, 1)) * 50
			get_parent().add_child(pedaso)
		fase = 2
		gira = true
		ataques.append("meteoro")
		yield(get_tree().create_timer(2,5), "timeout")
		gira = false
		escolha()
		return
	elif vida <= 0 and fase == 4:
		pass
	
	var atk =  ataques.pick_random()
	if atk == "varredura":
		varredura()
	elif atk == "laserx":
		laserx()
	elif atk == "laserx2":
		laserx2()
	elif atk == "meteoro":
		meteoro()
	else:
		print("oxe")
	
func meteoro():
	if fase == 2:
		$anim.play("punho meteoro E")
	elif fase == 3:
		$anim.play("punho meteoro D")
	#yield($anim, "animation_finished")
	yield(get_tree().create_timer(6), "timeout")
	var punho = preload("res://INIMIGOS/bosses/Punho.tscn").instance()
	punho.position.x = Global.player.position.x
	punho.position.z = Global.player.position.z
	punho.position.y = 10
	get_parent().add_child(punho)
	yield(self, "hit")
	for i in range(80):
			var pedaso = preload("res://VISUAL/DESTROÇOS/destroço.tscn").instance()
			pedaso.transform.origin = transform.origin
			pedaso.linear_velocity.x = (rand_range(-1, 1)) * 50
			pedaso.linear_velocity.z = (rand_range(-1, 1)) * 50
			pedaso.linear_velocity.y = (rand_range(-1, 1)) * 50
			get_parent().add_child(pedaso)
	gira = true
	if fase == 2:
		$"Node2/boss final/base fixa/cintura2/tronco2/mao E".visible = false
	elif fase == 3:
		$"Node2/boss final/base fixa/cintura2/tronco2/mao D".visible = false
	yield(get_tree().create_timer(2,5), "timeout")
	if fase == 2:
		fase = 3
		escolha()
		gira = false
	elif fase == 3:
		fase = 4
		vida = 10
	
	
	
func varredura():
	print("guarana")
	$anim.play("Varredura")
	yield(get_tree().create_timer(3), "timeout")
	varedura = true
	yield($anim, "animation_finished")
	varedura = false
	yield(get_tree().create_timer(2,5), "timeout")
	escolha()

func laserx():
	laser = true
	yield(self, "laserEnd")
	yield(get_tree().create_timer(2,5), "timeout")
	escolha()
	
	
func laserx2():
	atacando = true
	for i in range(3):
		if Global.player != null:
			var pos = Global.player.global_transform.origin
			look_at(Vector3(pos.x, transform.origin.y, pos.z), Vector3.UP)
			$laser2.look_at(pos, Vector3.UP)
			
			$laser2/bal.radius = 0.001
			$laser2/bal.visible = true
			
			yield(self, "bal")
			$laser2/lase/col.disabled = false
			$laser2/CSGBox.visible = true
			$laser2/bal.visible = false
			
			yield(get_tree().create_timer(0.5), "timeout")
			$laser2/lase/col.disabled = true
			$laser2/CSGBox.visible = false
		yield(get_tree().create_timer(2), "timeout")
	atacando = false
	escolha()
	
	
func _process(delta):
	
	if Input.is_action_just_pressed("ui_teste"):
		escolha()
	print(vida)
	if atacando == false and gira == false:
		if Global.player != null:
			var pos = Global.player.global_transform.origin
			look_at(Vector3(pos.x, transform.origin.y, pos.z), Vector3.UP)
	
	elif gira == true:
		rotate_y(10 * delta)
	
	if area == true and varedura == true and coldou >= 1:
		coldou = 0
		Global.player.vida -= 1
		Pimpact = 0.5 / delta
		player.velocidade.y += 1
		var particula = preload("res://VISUAL/faisca.tscn").instance()
		particula.global_transform = $faisca.global_transform
		particula.emitting = true
		get_parent().add_child(particula)
	else:
		if not coldou >= 1:
			coldou += delta
		
	if laser == true:
		laser1.visible = true
		#laser1.get_node("col").disabled = false
		laser1.dano = true
		
		laser2.visible = true
		#laser2.get_node("col").disabled = false
		laser2.dano = true
		
		if laser1.position.x >= 2:
			laser1.position.x -= delta
			
		if laser2.position.x <= -2:
			laser2.position.x += delta
			
		if not laser1.position.x >= 2 and not laser2.position.x <= -2:
			laser = false
			emit_signal("laserEnd")
	else:
		if laser2.position.x >= -11:
			laser2.position.x -= 5 * delta
		else:
			laser2.visible = false
			#laser2.get_node("col").disabled = true
			laser2.dano = false
			
		if laser1.position.x <= 11:
			laser1.position.x += 5 * delta
		else:
			laser1.visible = false
			#laser1.get_node("col").disabled = true
			laser1.dano = false
			
			
	if Pimpact > 0:
		Pimpact -= 1
		var frente = -transform.basis.z
		player.velocidade.x = frente.x * 50 * delta
		player.velocidade.z = frente.z * 50 * delta
		player.impact = true
		desimpact = true
	else:
		if desimpact == true:
			player.impact = false
			desimpact = false
	
	
	if $laser2/bal.radius < 0.4:
		$laser2/bal.radius += 0.15 * delta
		bal = true
	elif bal == true:
		bal = false
		emit_signal("bal")
	
	if vida <= 0 and fase == 4:
		for i in range(160):
			var pedaso = preload("res://VISUAL/DESTROÇOS/destroço.tscn").instance()
			pedaso.transform.origin = transform.origin
			pedaso.linear_velocity.x = (rand_range(-1, 1)) * 50
			pedaso.linear_velocity.z = (rand_range(-1, 1)) * 50
			pedaso.linear_velocity.y = (rand_range(-1, 1)) * 50
			get_parent().add_child(pedaso)
		get_parent().win = true
		queue_free()


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		area = true


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		area = false


func _on_lase_body_entered(body):
	if body.is_in_group("player"):
		body.vida -= 2


func _on_lase_body_exited(body):
	pass # Replace with function body.


func _on_Area2_body_entered(body):
	if body.is_in_group("player") and ativo == false:
		get_parent().get_node("AudioStreamPlayer").stream = preload("res://sons/luta_chefe.mp3")
		get_parent().get_node("AudioStreamPlayer").play()
		ativo = true
		
		get_parent().get_node("portas/Porta3").passe = false
		get_parent().get_node("portas/Porta3").get_node("lado1/anim").play("fechar")
		yield(get_tree().create_timer(2,5), "timeout")
		escolha()

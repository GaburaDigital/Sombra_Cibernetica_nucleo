extends KinematicBody
var fase = 1

var vida = 20

var ataques = ["varredura", "laserx", "laserx2"]
var area = false
var varedura = false
var coldou = 0

var laser = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var laser1 = get_parent().get_node("laser1")
onready var laser2 = get_parent().get_node("laser2")

signal laserEnd

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	yield(get_tree().create_timer(2,5), "timeout")
	escolha()
	
func escolha():
	
	if vida <= 0 and fase == 1:
		fase = 2
		
	
	var atk =  ataques.pick_random()
	if atk == "varredura":
		varredura()
	elif atk == "laserx":
		laserx()
	elif atk == "laserx2":
		laserx2()
	else:
		print("oxe")
	
func meteoro():
	$anim.play("punho meteoro D")
	var punho = preload("res://INIMIGOS/bosses/Punho.tscn").instance()
	punho.position.x = Global.player.position.x
	punho.position.z = Global.player.position.z
	punho.position.y = 10
	get_parent().add_child(punho)
	
func varredura():
	print("guarana")
	varedura = true
	$anim.play("Varredura")
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
	for i in range(3):
		if Global.player != null:
			var pos = Global.player.global_transform.origin
			look_at(Vector3(pos.x, transform.origin.y, pos.z), Vector3.UP)
			$laser2.look_at(pos, Vector3.UP)
			yield(get_tree().create_timer(2), "timeout")
			$laser2/col.disabled = false
			$laser2/CSGBox.visible = true
			
			yield(get_tree().create_timer(0.5), "timeout")
			$laser2/col.disabled = true
			$laser2/CSGBox.visible = false
		yield(get_tree().create_timer(2), "timeout")
	escolha()
	
	
func _process(delta):
	
	if Input.is_action_just_pressed("ui_teste"):
		escolha()
	
	
	
	if area == true and varedura == true and coldou >= 1:
		coldou = 0
		Global.player.vida -= 1
	else:
		if not coldou >= 1:
			coldou += delta
		
	if laser == true:
		laser1.visible = true
		laser1.get_node("col").disabled = false
		
		laser2.visible = true
		laser2.get_node("col").disabled = false
		
		
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
			laser2.get_node("col").disabled = true
			
		if laser1.position.x <= 11:
			laser1.position.x += 5 * delta
		else:
			laser1.visible = false
			laser1.get_node("col").disabled = true
			
			
	
	


func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		area = true


func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		area = false

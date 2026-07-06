extends KinematicBody
var tubo1 = false
var tubo2 = false
var tubo3 = false
var tubo4 = false

var vida = 20

var ataques = ["varredura"]
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
	yield(get_tree().create_timer(1), "timeout")
	laserx()
	
func meteoro():
	$anim.play("punho meteoro D")
	var punho = preload("res://INIMIGOS/bosses/Punho.tscn").instance()
	punho.position.x = Global.player.position.x
	punho.position.z = Global.player.position.z
	punho.position.y = 10
	get_parent().add_child(punho)
	
func varredura():
	varedura = true
	$anim.play("Varredura")
	yield($anim, "animation_finished")
	varedura = false

func laserx():
	laser = true
	yield(self, "laserEnd")
	
func laserx2():
	$laser2/col
	$laser2/CSGBox
	
func _process(delta):
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

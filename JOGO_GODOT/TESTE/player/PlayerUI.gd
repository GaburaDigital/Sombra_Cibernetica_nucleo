extends Control
signal next

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().connect("dialogo", self, "texto")
	pass # Replace with function body.
	
func texto(frase, npc):
	var enemies = []
	npc.get_node("camera").current = true
	get_parent().get_node("camera/camera").current = false
	get_parent().set_physics_process(false)
	
	for inimigo in get_tree().get_nodes_in_group("inimigo"):
		inimigo.set_physics_process(false)
		enemies.append(inimigo)
	for text in frase:
		$dialogueBox.percent_visible = 0
		$dialogueBox.text = text
		$anim.play("Escrita")
		yield($anim, "animation_finished")
		yield(get_tree().create_timer(2), "timeout")
		yield(self, "next")
	
		
	
	
	
	
	get_parent().set_physics_process(true)
	npc.get_node("camera").current = false
	get_parent().get_node("camera/camera").current = true
	$dialogueBox.text = ""

	yield(get_tree().create_timer(0.5), "timeout")
	
	for inim in enemies:
		if inim != null:
			inim.set_physics_process(true)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$moedas.text = str(Global.moeda)
	$modo.text = str(Global.modo)
	$vida.text = str(get_parent().vida)
	$municao.text = str(get_parent().mun)
	
	if Input.is_action_just_pressed("ui_home"):
		emit_signal("next")
	
	
#	pass

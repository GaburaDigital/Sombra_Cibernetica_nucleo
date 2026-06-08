extends Node2D
var botoes = []
var select
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	select = 2
	botoes = [$ButSair/ButtonSAIR, $ButDEV/ButtonDEV, $ButPlay/ButtonPLAY, $ButCONFIG/ButtonCONFIG]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_left"):
		if select
		select += 1


func _on_ButtonSAIR_button_down():
	$popUpSair.visible = true

func _on_ButtonDEV_button_down():
	pass # Replace with function body.


func _on_ButtonPLAY_button_down():
	get_tree().change_scene("res://CENAS/Laboratorio.tscn")


func _on_ButtonCONFIG_button_down():
	pass # Replace with function body.


func _on_sair_button_down():
	get_tree().quit()


func _on_ficar_button_down():
	$popUpSair.visible = false

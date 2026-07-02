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
	pass


func _on_ButtonSAIR_button_down():
	$popUpSair.visible = true

func _on_ButtonDEV_button_down():
	get_tree().change_scene("res://CENAS/Creditos.tscn")


func _on_ButtonPLAY_button_down():
	get_tree().change_scene("res://CENAS/Laboratorio.tscn")


func _on_ButtonCONFIG_button_down():
	get_tree().change_scene("res://CENAS/config.tscn")


func _on_sair_button_down():
	get_tree().quit()
	
func _on_ficar_button_down():
	$popUpSair.visible = false



func _on_ButtonSAIR_mouse_entered():
	$ButSair/AnimatedSprite.play("default")
func _on_ButtonSAIR_mouse_exited():
	$ButSair/AnimatedSprite.stop()


func _on_ButtonDEV_mouse_entered():
	$ButDEV/AnimatedSprite.play("default")
func _on_ButtonDEV_mouse_exited():
	$ButDEV/AnimatedSprite.stop()

func _on_ButtonPLAY_mouse_entered():
	$ButPlay/AnimatedSprite.play("default")
func _on_ButtonPLAY_mouse_exited():
	$ButPlay/AnimatedSprite.stop()

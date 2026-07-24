extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.menu = true
	$Node2D/audio/scroll.value = Global.volume
	$Node2D/musica/scroll.value = Global.musica
	$Node2D/sensibilidade/scroll.value = Global.sensibilidade
	$Node2D/tela/CheckBox.pressed = Global.telacheia
	$Node2D/brilho/scroll.value = Global.brilho


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Global.volume = $Node2D/audio/scroll.value
	Global.musica = $Node2D/musica/scroll.value
	Global.sensibilidade = $Node2D/sensibilidade/scroll.value
	Global.telacheia = $Node2D/tela/CheckBox.pressed
	Global.brilho = $Node2D/brilho/scroll.value


func _on_ButtonSAIR_button_down():
	get_tree().change_scene("res://CENAS/Menu.tscn")

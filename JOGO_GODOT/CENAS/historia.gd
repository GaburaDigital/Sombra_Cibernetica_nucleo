extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.menu = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ButtonPLAY_button_down():
	get_tree().change_scene("res://CENAS/Creditos.tscn")


func _on_ButtonSAIR_button_down():
	get_tree().change_scene("res://CENAS/Menu.tscn")

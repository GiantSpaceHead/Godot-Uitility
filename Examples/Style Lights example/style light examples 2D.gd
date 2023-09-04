extends Node2D

@onready var Light = $StyleLight2D


func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		
		if Light.Style == StyleLight2D.SArray.STATIC:
			Light.StyleFSM(StyleLight2D.SArray.STROBE)
		elif Light.Style == StyleLight2D.SArray.STROBE:
			Light.StyleFSM(StyleLight2D.SArray.FLICKER)
		elif Light.Style == StyleLight2D.SArray.FLICKER:
			Light.StyleFSM(StyleLight2D.SArray.STATIC)

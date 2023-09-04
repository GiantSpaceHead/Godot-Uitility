extends Node3D

@onready var Light = $StyleLight3D


func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		
		if Light.Style == StyleLight3D.SArray.STATIC:
			Light.StyleFSM(StyleLight3D.SArray.STROBE)
		elif Light.Style == StyleLight3D.SArray.STROBE:
			Light.StyleFSM(StyleLight3D.SArray.FLICKER)
		elif Light.Style == StyleLight3D.SArray.FLICKER:
			Light.StyleFSM(StyleLight3D.SArray.STATIC)

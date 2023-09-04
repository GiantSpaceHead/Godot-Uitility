extends PointLight2D
class_name StyleLight2D


@export var Base_Energy = float(1)

@export var Wait = float(0.5)

@export var Strobe_Amount = float(1) 

enum SArray {STATIC, STROBE, FLICKER}

@export var Style = SArray.STATIC


var Stop = false

func _ready():
	
	energy = Base_Energy
	
	StyleFSM(Style)



func Static():
	energy = Base_Energy


func Strobe():
	var tween = create_tween().set_loops()
	
	tween.tween_property(self, "energy", energy - Strobe_Amount, Wait)
	tween.tween_property(self, "energy", Base_Energy, Wait)
	
	if Stop:
		tween.kill()


func Flicker():
	
	energy = Base_Energy - 0.1
	await create_tween().set_loops().tween_interval(0.1).finished
	energy = Base_Energy
	await create_tween().set_loops().tween_interval(0.1).finished
	energy = Base_Energy - 0.2
	await create_tween().set_loops().tween_interval(0.1).finished
	energy = Base_Energy + 0.1
	await create_tween().set_loops().tween_interval(0.1).finished
	energy = Base_Energy - 0.3
	await create_tween().set_loops().tween_interval(0.1).finished
	
	if not Stop:
		Flicker()




func StyleFSM(Set_Style):
	
	
	if not Set_Style == null:
		Style = Set_Style
	
	
	match Style:
		SArray.STATIC:
			energy = Base_Energy
		SArray.STROBE:
			Strobe()
			
		SArray.FLICKER:
			Flicker()


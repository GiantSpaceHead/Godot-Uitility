extends OmniLight3D
class_name StyleLight3D


@export var Base_Energy = float(1)

@export var Wait = float(0.5)

@export var Strobe_Amount = float(1) 

enum SArray {STATIC, STROBE, FLICKER}

@export var Style = SArray.STATIC



#	The Styles are all sorted into methods for readability


func Static():
	light_energy = Base_Energy




#	Light effects are made by manipulating node propertys using tweens
#	instead of using the tweens set_loops() function to make the tweens loop indfinitly
#	I check to see if Style var has changed, if it hasn't, I use tween_callback to call the method again,
#	if it has changed, I use the kill function on the tween.
#	this way if I change the Light Style, the tween will not keep repeating.

func Strobe():
	var tween = create_tween()
	
	tween.tween_property(self, "light_energy", light_energy - Strobe_Amount, Wait)
	tween.tween_property(self, "light_energy", Base_Energy, Wait)
	
	if not Style == SArray.STROBE:
		tween.kill()
	else:
		tween.tween_callback(Strobe)


func Flicker():
	
	light_energy = Base_Energy - 0.1
	await create_tween().set_loops().tween_interval(0.1).finished
	light_energy = Base_Energy
	await create_tween().set_loops().tween_interval(0.1).finished
	light_energy = Base_Energy - 0.2
	await create_tween().set_loops().tween_interval(0.1).finished
	light_energy = Base_Energy + 0.1
	await create_tween().set_loops().tween_interval(0.1).finished
	light_energy = Base_Energy - 0.3
	await create_tween().set_loops().tween_interval(0.1).finished
	
	if Style == SArray.FLICKER:
		Flicker()


#	The methods above are called using this method below.


func StyleFSM(Set_Style):
	
	
	if not Set_Style == null:
		Style = Set_Style
	
	
	match Style:
		SArray.STATIC:
			light_energy = Base_Energy
		SArray.STROBE:
			Strobe()
			
		SArray.FLICKER:
			
			#tween and rand_range used to create a delay before Flicker method
			#to desync it from other StyleLights at the start of the scene
			
			var FR = randf_range(0.1,1)
			var tween = create_tween()
			
			tween.tween_interval(FR)
			tween.tween_callback(Flicker)

#	The method StyleFSM is used called once at the start of a scene.
#	This method can later be called again to change the Style.

func _ready():
	Base_Energy = light_energy
	StyleFSM(Style)

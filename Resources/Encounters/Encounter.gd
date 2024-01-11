extends Resource
class_name Encounter

@export var encounter_name := "Encounter"
const enemysizelimit = 3
## SIZE MUST BE AT MAX 3
@export var enemies : Array[PackedScene] = [
]
@export_group("Music")
@export var music :AudioStream = null
@export_group("","")
@export var mercy_options = [
	"  * Spare",
	"  * Flee",
]
func _init():
	if enemies.size() > 3: enemies.resize(3)
	

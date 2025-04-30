extends Node;

class_name AbilitySet;

var abilities: Array[AbilityController];

var count:
	get:
		return abilities.size();

func _ready():
	abilities.assign(get_children().filter(func(child): return child is AbilityController));
	
	pass


func get_at(index: int) -> AbilityController:
	return abilities[index];

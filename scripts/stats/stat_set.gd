extends Node

class_name StatSet;

var stats: Array[StatController];

var count:
	get:
		return stats.size();


func _ready():
	stats.assign(get_children().filter(func(child): return child is AbilityController));
	
	pass


extends Node

class_name StatController;

@export
var base_value: float;

var current_value: float;

var value: float:
	get:
		return base_value;
	set(newValue):
		base_value = newValue;
		compute();

var modifiers: Array[StatModifier];

func _ready():
	modifiers.assign(get_children().filter(func(child): return child is StatModifier));
	compute();

	pass


func compute():
	var base = base_value;
	var current = base_value;
	for modifier in modifiers:
		var values = modifier.modify(base, current);
		base = values.base;
		current = values.current;
		pass
	
	base_value = base;
	current_value = current;
	pass


func add_modifier(statModifier: StatModifier):
	modifiers.push_back(statModifier);
	compute();
	pass


func remove_modifier(statModifier: StatModifier):
	modifiers.erase(statModifier);
	compute();
	pass

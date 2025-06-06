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
	current_value = base_value;
	for modifier in modifiers:
		current_value = modifier.modify(base_value, current_value);
		pass
	pass


func add_modifier(statModifier: StatModifier):
	modifiers.push_back(statModifier);
	compute();
	pass


func remove_modifier(statModifier: StatModifier):
	modifiers.erase(statModifier);
	compute();
	pass

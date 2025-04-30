extends Node

class_name StatSet;

var stats: Dictionary[StringName, StatController];
var count:
	get:
		return stats.size();


func _ready():
	var stat_controllers = get_children().filter(func(child): return child is StatController)
	stats.assign(stat_controllers.reduce(func(_stats, stat):
		_stats[stat.name] = stat;
		return _stats, {}));

	pass


func get_stat(stat: StringName) -> StatController:
	return stats[stat];


func set_stat(stat: StringName, value: float):
	stats[stat].value = value;
	pass

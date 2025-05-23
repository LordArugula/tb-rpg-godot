extends Node

class_name AbilityTargetController;

var filters: Array[AbilityTargetFilter];

func _ready() -> void:
	filters.assign(get_children().filter(func(child): return child is AbilityTargetFilter));
	pass


func get_targets(actor: ActorController, actors: Array[ActorController]) -> Array[ActorController]:
	return filters.reduce(func(targets, filter): return filter.apply(actor, targets), actors)

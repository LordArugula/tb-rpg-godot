extends Node

class_name AbilityTargetController;

var filters: Array[AbilityTargetFilter];

func _ready() -> void:
	filters.assign(get_children().filter(func(child): return child is AbilityTargetFilter));
	pass

func can_target(actor: ActorController, target: ActorController):
	return filters.all(func(filter: AbilityTargetFilter):
		return filter.can_target(actor, target);
	);

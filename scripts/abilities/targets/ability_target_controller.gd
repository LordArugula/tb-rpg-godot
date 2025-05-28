extends Node

class_name AbilityTargetController;

var filters: Array[AbilityTargetFilter];

func _ready() -> void:
	filters.assign(get_children().filter(func(child): return child is AbilityTargetFilter));
	pass


func can_target(actor: ActorController, target: ActorController) -> bool:
	return filters.all(func(filter: AbilityTargetFilter): return filter.matches(actor, [target]));


func matches(actor: ActorController, targets: Array[ActorController]) -> bool:
	return targets.all(func(target):
		return filters.all(func(filter: AbilityTargetFilter):
			return filter.matches(actor, target);
		);
	);

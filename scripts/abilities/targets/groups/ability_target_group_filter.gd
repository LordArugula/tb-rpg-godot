extends Node;

class_name AbilityTargetGroupFilter;

var filters: Array[AbilityTargetFilter];

func _ready() -> void:
	filters.assign(get_children().filter(func(child): return child is AbilityTargetFilter));
	pass


func get_target_groups(_actor: ActorController, _targets: Array[ActorController]) -> Array[TargetGroup]:
	push_error("Function not implemented.");
	return [];


func get_possible_targets(actor: ActorController, targets: Array[ActorController]) -> Array[ActorController]:
	return targets.filter(func(target): return filters.all(func(filter): return filter.can_target(actor, target)));


class TargetGroup:
	var targets: Array[ActorController];
	var name: StringName;
	
	func _init(actors: Array[ActorController], _name: StringName) -> void:
		targets.assign(actors);
		self.name = _name;
		pass

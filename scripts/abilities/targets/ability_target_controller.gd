extends Node

class_name AbilityTargetController;

var groupFilters: Array[AbilityTargetGroupFilter];

func _ready() -> void:
	groupFilters.assign(get_children().filter(func(child): return child is AbilityTargetGroupFilter));
	pass


func get_target_groups(actor: ActorController, targets: Array[ActorController]) -> Array[AbilityTargetGroupFilter.TargetGroup]:
	var targetGroups: Array[AbilityTargetGroupFilter.TargetGroup];
	for groupFilter in groupFilters:
		var groups = groupFilter.get_target_groups(actor, targets);
		targetGroups.append_array(groups);
		pass
	
	return targetGroups;

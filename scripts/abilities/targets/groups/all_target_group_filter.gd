extends AbilityTargetGroupFilter;

func get_target_groups(_actor: ActorController, targets: Array[ActorController]) -> Array[TargetGroup]:
	var possibleTargets = get_possible_targets(_actor, targets);
	return [TargetGroup.new(possibleTargets, "All")];

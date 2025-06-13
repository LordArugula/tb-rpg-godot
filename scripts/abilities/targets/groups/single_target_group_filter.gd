extends AbilityTargetGroupFilter;

func get_target_groups(_actor: ActorController, targets: Array[ActorController]) -> Array[TargetGroup]:
	var targetGroups: Array[TargetGroup] = [];
	var possibleTargets = get_possible_targets(_actor, targets);
	targetGroups.assign(possibleTargets.map(func(actor): return TargetGroup.new([actor], actor.name)));
	return targetGroups;

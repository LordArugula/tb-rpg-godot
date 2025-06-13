extends AbilityTargetFilter;

func matches(_actor: ActorController, targets: Array[ActorController]) -> bool:
	return targets.size() == 1;

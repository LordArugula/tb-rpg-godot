extends AbilityTargetFilter;

@export
var count: int;

func matches(_actor: ActorController, targets: Array[ActorController]) -> bool:
	return targets.size() >= count;

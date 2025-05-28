extends AbilityTargetFilter;

@export
var maxTargets: int;

func matches(_actor: ActorController, actors: Array[ActorController]) -> bool:
	return actors.size() <= maxTargets;

extends AbilityTargetFilter;

@export
var minTargets: int;

func matches(_actor: ActorController, actors: Array[ActorController]) -> bool:
	return actors.size() >= minTargets;

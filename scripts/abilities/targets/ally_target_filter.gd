extends AbilityTargetFilter;

func matches(actor: ActorController, actors: Array[ActorController]) -> bool:
	return actors.all(func(target): return target.faction == actor.faction)

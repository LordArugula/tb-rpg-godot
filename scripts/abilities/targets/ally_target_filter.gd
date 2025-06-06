extends AbilityTargetFilter;

func apply(actor: ActorController, actors: Array[ActorController]) -> Array[ActorController]:
	return actors.filter(func(target): return target.faction == actor.faction);


func matches(actor: ActorController, actors: Array[ActorController]) -> bool:
	return actors.all(func(target): return target.faction == actor.faction);

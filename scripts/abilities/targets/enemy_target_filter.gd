extends AbilityTargetFilter;

func can_target(actor: ActorController, target: ActorController) -> bool:
	return target.faction != actor.faction;


func matches(actor: ActorController, targets: Array[ActorController]) -> bool:
	return targets.all(func(target): return target.faction != actor.faction)

extends AbilityTargetFilter;

func can_target(_actor: ActorController, _target: ActorController) -> bool:
	return true;


func matches(_actor: ActorController, targets: Array[ActorController]) -> bool:
	return targets.size() == 1;

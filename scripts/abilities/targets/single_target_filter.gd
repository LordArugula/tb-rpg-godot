extends AbilityTargetFilter;

func apply(actor: ActorController, actors: Array[ActorController]) -> Array[ActorController]:
    return actors;


func matches(actor: ActorController, actors: Array[ActorController]) -> bool:
    return actors.size() == 1;

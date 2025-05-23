extends AbilityTargetFilter;

func apply(actor: ActorController, actors: Array[ActorController]) -> Array[ActorController]:
    return actors.filter(func(target): target != actor);


func matches(actor: ActorController, actors: Array[ActorController]) -> bool:
    return actors.all(func(target): target != actor)

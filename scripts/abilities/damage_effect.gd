extends AbilityEffect;

@export
var amount: float;

func start(_actor: ActorController, _targets: Array[ActorController]):
	pass


func apply(actor: ActorController, targets: Array[ActorController]):
	print("%s dealt %d to %s." % [actor, floorf(amount), targets]);
	pass


func resolve(_actor: ActorController, _targets: Array[ActorController]):
	pass

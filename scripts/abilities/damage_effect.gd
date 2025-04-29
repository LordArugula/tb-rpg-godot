extends AbilityEffect;

func start(actor: ActorController, targets: Array[ActorController]):
	pass


func apply(actor: ActorController, targets: Array[ActorController]):
	print("%s dealt %s to %s." % [actor, 10, targets]);
	pass


func resolve(actor: ActorController, targets: Array[ActorController]):
	pass

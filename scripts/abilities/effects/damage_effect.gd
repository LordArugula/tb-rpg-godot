extends AbilityEffect;

@export
var amount: float;

func start(_actor: ActorController, _targets: Array[ActorController]):
	pass


func apply(actor: ActorController, targets: Array[ActorController]):
	for target in targets:
		target.take_damage(floorf(amount));
		print("%s dealt %d to %s." % [actor, floorf(amount), target]);
		pass

	pass


func resolve(_actor: ActorController, _targets: Array[ActorController]):
	pass

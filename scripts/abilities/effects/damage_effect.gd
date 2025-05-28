extends AbilityEffect;

@export
var amount: float;

func start(_actor: ActorController, _targets: Array[ActorController]):
	pass


func apply(actor: ActorController, targets: Array[ActorController]):
	for target in targets:
		print("%s dealt %d to %s." % [actor, floorf(amount), target]);
		target.take_damage(floorf(amount));
		pass

	pass


func resolve(_actor: ActorController, _targets: Array[ActorController]):
	pass

extends AbilityEffect;

@export
var amount: float;

func start(_actor: ActorController, _targets: Array[ActorController]):
	pass


func apply(_actor: ActorController, targets: Array[ActorController]):
	for target in targets:
		target.take_damage(floorf(amount));
		pass

	pass


func resolve(_actor: ActorController, _targets: Array[ActorController]):
	pass

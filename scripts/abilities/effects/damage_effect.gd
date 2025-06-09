extends AbilityEffect;

@export
var amount: float;

func start(_actor: ActorController, _targets: Array[ActorController]):
	pass


func apply(actor: ActorController, targets: Array[ActorController]):
	var damage = actor.get_base_damage() * amount;
	for target in targets:
		target.take_damage(floorf(damage));
		pass

	pass


func resolve(_actor: ActorController, _targets: Array[ActorController]):
	pass

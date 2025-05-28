extends Node

class_name BattleManager;

var turnQueue: TurnQueue;

var knockedOutActors: Array[ActorController];

func _ready() -> void:
	var children = get_children().filter(func(child: Node): return child is ActorController);

	turnQueue = TurnQueue.new();
	for child in children:
		child.knocked_out.connect(_on_actor_knocked_out);
		turnQueue.add_end(child);
		pass

	while (true):
		if (turnQueue.actors.all(func(_actor): return _actor.faction == "Player")):
			print("Game Win");
			break;

		if (!turnQueue.actors.any(func(_actor): return _actor.faction == "Player")):
			print("Game Loss");
			break;

		var actor: ActorController = turnQueue.get_current();
		print("%s started their turn." % actor.name);
		actor_turn_started.emit(actor);
		
		var abilitySelectedResult = await actor_ability_selected;
		var ability = abilitySelectedResult[1];
		print("%s selected %s" % [actor.name, ability.name]);

		var abilityTargetsSelectedResult = await actor_ability_targets_selected;
		var targets = abilityTargetsSelectedResult[2];
		print("%s used %s on %s" % [actor.name, ability.name, targets]);

		actor.activate_ability(ability, [targets]);

		actor_turn_ended.emit(actor);

		print("%s ended their turn." % actor.name);

		turnQueue.move_next();
		pass
	
	pass


func get_possible_targets(actor: ActorController, ability: AbilityController):
	return turnQueue.actors.filter(func(target: ActorController): return ability.can_target(actor, target));


func _on_actor_knocked_out(actor: ActorController):
	turnQueue.remove(actor);
	knockedOutActors.push_back(actor);
	print("%s was knocked out." % actor.name)
	remove_child(actor);

	pass


signal actor_turn_started(actor: ActorController);
signal actor_turn_ended(actor: ActorController);
signal actor_ability_selected(actor: ActorController, ability: AbilityController);
signal actor_ability_targets_selected(actor: ActorController, ability: AbilityController, targets: Array[ActorController]);

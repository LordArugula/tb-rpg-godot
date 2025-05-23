extends Node

var turnQueue: TurnQueue;

func _ready() -> void:
	var children = get_children().filter(func(child: Node): return child is ActorController);

	turnQueue = TurnQueue.new();
	for child in children:
		turnQueue.add_end(child);
		pass

	while (true):
		var actor = turnQueue.get_current();
		print("%s started their turn." % actor.name);
		actor.start_turn();

		await actor.turn_ended;
		print("%s ended their turn." % actor.name);

		turnQueue.move_next();
		pass

	pass

func _input(event: InputEvent) -> void:
	if (event is InputEventKey and event.is_pressed()):
		if (event.keycode >= KEY_1 and event.keycode < KEY_9):
			var index = event.keycode - KEY_1;
			var actor = turnQueue.get_current();

			if actor.current_ability == null:
				if (index >= 0 and index < actor.abilities.count):
					var ability = actor.abilities.get_at(index);
					actor.ability_selected.emit(ability);
					
					var targets = await ability_targets_selected;
					actor.targets_selected.emit(targets);
					pass
			else:			
				var possible_targets = actor.current_ability.target_controller.get_targets(actor, turnQueue.actors);
				if (index >= 0 and index < possible_targets.size()):
					ability_targets_selected.emit([possible_targets[index]]);

	pass


signal ability_targets_selected(targets: Array[ActorController]);

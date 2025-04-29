extends Node

var turnQueue: TurnQueue;

func _ready() -> void:
	var children = get_children().filter(func(child: Node): return child is ActorController);

	turnQueue = TurnQueue.new();
	for child in children:
		turnQueue.add_end(child);
		pass

	while (true):
		var character = turnQueue.get_current();
		print("%s started their turn." % character.name);
		character.start_turn();

		await character.turn_ended;
		print("%s ended their turn." % character.name);

		turnQueue.move_next();
		pass

	pass


func _input(event: InputEvent) -> void:
	if (event is InputEventKey and event.is_pressed()):
		if (event.keycode >= KEY_1 and event.keycode < KEY_9):
			var index = event.keycode - KEY_1;
			var character = turnQueue.get_current();

			if (index >= 0 and index < character.abilities.size()):
				character.ability_selected.emit(character.abilities[index]);
				pass
			pass
		elif (event.keycode == KEY_SPACE):
			var character = turnQueue.get_current();
			
			var targets = turnQueue.characters.filter(func (actor): return actor != character);
			var target = targets.pick_random();
			character.targets_selected.emit([target]);
			pass
	pass

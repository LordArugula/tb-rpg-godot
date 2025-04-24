extends Node

var turnQueue: TurnQueue;

func _ready() -> void:
	var children = get_children().filter(func(child: Node): return child is ActorController);

	turnQueue = TurnQueue.new();
	for child in children:
		turnQueue.add_end(child);
		pass
	
	var character = turnQueue.get_next();
	# perform action
	print(character);

	pass


func _input(event: InputEvent) -> void:
	if (event is InputEventKey and event.is_pressed()):
		if (event.keycode == KEY_SPACE):
			turnQueue.move_next();
			
			var character = turnQueue.get_next();
			# perform action
			print(character);
			
			pass

	pass

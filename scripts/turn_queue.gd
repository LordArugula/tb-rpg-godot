class_name TurnQueue;

var characters: Array[ActorController];
var current: int;


func move_next():
	current = (current + 1) % characters.size();
	pass


func move_prev():
	current = (current + characters.size() - 1) % characters.size();
	pass


func add_end(character: ActorController):
	characters.push_back(character);
	pass


func add_back(character: ActorController):
	characters.push_front(character);
	pass


func remove(character: ActorController):
	characters.erase(character);
	pass


func get_next() -> ActorController:
	return characters[current];

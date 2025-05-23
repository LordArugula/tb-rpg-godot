class_name TurnQueue;

var actors: Array[ActorController];
var current: int;


func move_next():
	current = (current + 1) % actors.size();
	pass


func move_prev():
	current = (current + actors.size() - 1) % actors.size();
	pass


func add_end(actor: ActorController):
	actors.push_back(actor);
	pass


func add_back(actor: ActorController):
	actors.push_front(actor);
	pass


func remove(actor: ActorController):
	actors.erase(actor);
	pass


func get_current() -> ActorController:
	return actors[current];

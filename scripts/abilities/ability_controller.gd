extends Node;

class_name AbilityController;

var effects: Array[AbilityEffect];

@onready
var target_controller: AbilityTargetController = $AbilityTargetController;

func _ready():
	effects.assign(get_children().filter(func(child): return child is AbilityEffect));
	
	pass


func activate(actor: ActorController, targets: Array[ActorController]):
	for effect in effects:
		effect.start(actor, targets);
		pass

	on_activated.emit(actor, targets);
	pass


func apply(actor: ActorController, targets: Array[ActorController]):
	for effect in effects:
		effect.apply(actor, targets);
		pass

	pass


func resolve(actor: ActorController, targets: Array[ActorController]):
	for effect in effects:
		effect.resolve(actor, targets);
		pass

	on_resolved.emit(actor, targets);
	pass


signal on_activated(actor: ActorController, targets: Array[ActorController]);
signal on_resolved(actor: ActorController, targets: Array[ActorController]);

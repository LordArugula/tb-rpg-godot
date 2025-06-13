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


func get_target_groups(actor: ActorController, targets: Array[ActorController]) -> Array[AbilityTargetGroupFilter.TargetGroup]:
	return target_controller.get_target_groups(actor, targets);


func can_target(actor: ActorController, target: ActorController):
	return target_controller.can_target(actor, target);


signal on_activated(actor: ActorController, targets: Array[ActorController]);
signal on_resolved(actor: ActorController, targets: Array[ActorController]);

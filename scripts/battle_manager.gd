extends Node

class_name BattleManager;

var turnQueue: TurnQueue;

func _ready() -> void:
	var children = get_children().filter(func(child: Node): return child is ActorController);

	turnQueue = TurnQueue.new();
	for child in children:
		turnQueue.add_end(child);
		pass

	start_battle.call_deferred();
	pass


func start_battle():
	battle_started.emit();
	start_turn();
	pass


func start_turn():
	var actor = turnQueue.get_current();
	actor_turn_started.emit(actor);
	actor.start_turn();

	pass


func end_turn():
	var actor = turnQueue.get_current();
	actor_turn_ended.emit(actor);
	actor.end_turn();

	if turnQueue.actors.all(func(_actor): return _actor.faction != &"Player"):
		battle_ended.emit();
		battle_lost.emit();
		return ;

	if turnQueue.actors.all(func(_actor): return _actor.faction == &"Player"):
		battle_ended.emit();
		battle_won.emit();
		return ;

	turnQueue.move_next();
	start_turn();
	pass


func select_ability(actor: ActorController, ability: AbilityController):
	actor_ability_selected.emit(actor, ability);
	pass


func unselect_ability(actor: ActorController, ability: AbilityController):
	actor_ability_unselected.emit(actor, ability);
	pass


func confirm_ability_targets(actor: ActorController, ability: AbilityController, targets: Array[ActorController]):
	actor_ability_used.emit(actor, ability, targets);
	actor.activate_ability(ability, targets);

	end_turn();
	pass


func get_possible_targets(actor: ActorController, ability: AbilityController) -> Array[ActorController]:
	return turnQueue.actors.filter(func(_actor): return ability.can_target(actor, _actor));


signal actor_ability_selected(actor: ActorController, ability: AbilityController);
signal actor_ability_unselected(actor: ActorController, ability: AbilityController);

signal battle_started();
signal battle_ended();
signal battle_won();
signal battle_lost();

signal actor_turn_started(actor: ActorController);
signal actor_turn_ended(actor: ActorController);
signal actor_ability_used(actor: ActorController, ability: AbilityController, targets: Array[ActorController]);

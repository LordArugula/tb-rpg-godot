extends Node

class_name BattleManager;

var turnQueue: TurnQueue;

func _ready() -> void:
	var actors = get_children().filter(func(child: Node): return child is ActorController);

	turnQueue = TurnQueue.new();
	for actor: ActorController in actors:
		actor.damage_taken.connect(_on_actor_damage_taken);
		actor.healing_taken.connect(_on_actor_healing_taken);
		actor.knocked_out.connect(_on_actor_knocked_out);

		actor.mouse_entered.connect(_on_actor_mouse_entered);
		actor.mouse_exited.connect(_on_actor_mouse_exited);
		
		turnQueue.add_end(actor);
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


func _on_actor_damage_taken(actor: ActorController, damage: float):
	actor_damage_taken.emit(actor, damage);
	pass


func _on_actor_healing_taken(actor: ActorController, healing: float):
	actor_healing_taken.emit(actor, healing);
	pass


func _on_actor_knocked_out(actor: ActorController):
	actor_knocked_out.emit(actor);
	pass


func _on_actor_mouse_entered(actor: ActorController):
	actor_mouse_entered.emit(actor);
	pass


func _on_actor_mouse_exited(actor: ActorController):
	actor_mouse_exited.emit(actor);
	pass


signal battle_started();
signal battle_ended();
signal battle_won();
signal battle_lost();

signal actor_turn_started(actor: ActorController);
signal actor_turn_ended(actor: ActorController);
signal actor_ability_used(actor: ActorController, ability: AbilityController, targets: Array[ActorController]);

signal actor_damage_taken(actor: ActorController, damage: float);
signal actor_healing_taken(actor: ActorController, healing: float);
signal actor_knocked_out(actor: ActorController);

signal actor_ability_selected(actor: ActorController, ability: AbilityController);
signal actor_ability_unselected(actor: ActorController, ability: AbilityController);
signal actor_mouse_entered(actor: ActorController);
signal actor_mouse_exited(actor: ActorController);

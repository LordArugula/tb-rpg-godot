extends Node

@onready
var battleManager: BattleManager = $"/root/Main/BattleManager";

func _ready() -> void:
	battleManager.battle_started.connect(_on_battle_manager_battle_started);
	battleManager.battle_won.connect(_on_battle_manager_battle_won);
	battleManager.battle_lost.connect(_on_battle_manager_battle_lost);

	battleManager.actor_turn_started.connect(_on_battle_manager_actor_turn_started);
	battleManager.actor_turn_ended.connect(_on_battle_manager_actor_turn_ended);
	battleManager.actor_ability_used.connect(_on_battle_manager_actor_ability_used);
	battleManager.actor_knocked_out.connect(_on_battle_manager_actor_knocked_out);
	
	battleManager.actor_damage_taken.connect(_on_battle_manager_actor_damaged);
	battleManager.actor_healing_taken.connect(_on_battle_manager_actor_healed);

	pass


func _on_battle_manager_battle_started():
	print("Battle started!");
	pass


func _on_battle_manager_battle_won():
	print("Battle won!");
	pass


func _on_battle_manager_battle_lost():
	print("Battle lost!");
	pass


func _on_battle_manager_actor_turn_started(actor: ActorController):
	print("%s started their turn." % actor.name);
	pass


func _on_battle_manager_actor_turn_ended(actor: ActorController):
	print("%s ended their turn." % actor.name);
	pass


func _on_battle_manager_actor_ability_used(actor: ActorController, ability: AbilityController, targets: Array[ActorController]):
	print("%s used %s on %s." % [actor.name, ability.name, targets.map(func(target): return target.name)]);
	pass


func _on_battle_manager_actor_knocked_out(actor: ActorController):
	print("%s was knocked out." % actor.name);
	pass


func _on_battle_manager_actor_damaged(actor: ActorController, damage: float):
	print("%s took %.0f damage." % [actor.name, damage]);
	pass


func _on_battle_manager_actor_healed(actor: ActorController, healing: float):
	print("%s took %.0f healing." % [actor.name, healing]);
	pass

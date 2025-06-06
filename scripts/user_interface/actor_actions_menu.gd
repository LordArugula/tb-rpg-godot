extends Node

@onready
var battle_manager: BattleManager = $"/root/Main/BattleManager";

func _ready() -> void:
	battle_manager.actor_turn_started.connect(_on_battle_manager_actor_turn_started);
	battle_manager.actor_ability_unselected.connect(_on_battle_manager_actor_ability_unselected);
	pass


func _on_battle_manager_actor_turn_started(actor: ActorController):
	show_menu(actor);
	pass


func _on_battle_manager_actor_ability_unselected(actor: ActorController, _ability: AbilityController):
	show_menu(actor);
	pass


func show_menu(actor: ActorController):
	for ability in actor.abilities.abilities:
		var button = Button.new();
		button.text = ability.name;
		button.pressed.connect(func():
			battle_manager.select_ability(actor, ability);
			hide_menu();
			pass
		);

		self.add_child(button);
		pass
	pass


func hide_menu():
	for child in self.get_children():
		child.queue_free();
	
	pass

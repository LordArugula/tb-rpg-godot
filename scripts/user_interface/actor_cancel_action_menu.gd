extends Node

@onready
var battle_manager: BattleManager = $"/root/Main/BattleManager";

func _ready() -> void:
	battle_manager.actor_ability_selected.connect(_on_battle_manager_actor_ability_selected);
	battle_manager.actor_ability_used.connect(_on_battle_manager_actor_ability_used);
	pass


func _on_battle_manager_actor_ability_selected(actor: ActorController, ability: AbilityController):
	show_menu(actor, ability);
	pass


func _on_battle_manager_actor_ability_used(_actor: ActorController, _ability: AbilityController, _targets: Array[ActorController]):
	hide_menu();
	pass


func show_menu(actor: ActorController, ability: AbilityController):
	var button = Button.new();
	button.text = "Cancel";
	button.pressed.connect(func():
		battle_manager.unselect_ability(actor, ability);
		hide_menu();
		pass
	);

	self.add_child(button);
	pass


func hide_menu():
	for child in self.get_children():
		child.queue_free();
	
	pass

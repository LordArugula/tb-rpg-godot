extends Control;

@onready
var battle_manager: BattleManager = $"/root/Main/BattleManager";

var __actor: ActorController;
var __ability: AbilityController;

func _ready() -> void:
	battle_manager.actor_ability_selected.connect(_on_battle_manager_actor_ability_selected);
	battle_manager.actor_ability_used.connect(_on_battle_manager_actor_ability_used);

	hide_menu();
	pass


func _on_battle_manager_actor_ability_selected(actor: ActorController, ability: AbilityController):
	__actor = actor;
	__ability = ability;
	show_menu();
	pass


func _on_battle_manager_actor_ability_used(_actor: ActorController, _ability: AbilityController, _targets: Array[ActorController]):
	hide_menu();
	pass


func show_menu():
	var button = Button.new();
	button.text = "Cancel";
	button.pressed.connect(cancel_action);

	self.add_child(button);
	show();

	pass


func hide_menu():
	for child in self.get_children():
		child.queue_free();
	
	hide();
	
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		cancel_action();
		pass
	
	pass


func cancel_action():
	battle_manager.unselect_ability(__actor, __ability);
	
	__actor = null;
	__ability = null;

	hide_menu();
	pass

extends Node;

@onready
var container: Container = $AbilityButtonContainer;
@onready
var battle_manager: BattleManager = $"/root/Main/BattleManager";

func _ready():
	battle_manager.actor_turn_started.connect(_on_battle_manager_actor_turn_started);
	hide_menu();
	pass


func _on_battle_manager_actor_turn_started(actor: ActorController) -> void:
	show_menu(actor);
	container.grab_focus();
	pass


func show_menu(actor: ActorController):
	for ability in actor.abilities.abilities:
		var button = Button.new();
		button.text = ability.name;
		button.pressed.connect(func ():
			battle_manager.actor_ability_selected.emit(actor, ability);
			hide_menu();
			pass
		)
		container.add_child(button);
		pass
	
	container.show();
	pass


func hide_menu():
	container.hide();

	for child in container.get_children():
		child.queue_free();
		pass

	pass

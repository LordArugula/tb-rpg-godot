extends Node;

@onready
var container: Control = $AbilityTargetContainer;
@onready
var battle_manager: BattleManager = $"/root/Main/BattleManager";
@onready
var camera: Camera3D = $"/root/Main/Camera3D";

func _ready():
	battle_manager.actor_ability_selected.connect(_on_battle_manager_actor_ability_selected);
	hide_menu();
	pass


func _on_battle_manager_actor_ability_selected(actor: ActorController, ability: AbilityController) -> void:
	show_menu(actor, ability);
	container.grab_focus();
	pass


func show_menu(actor: ActorController, ability: AbilityController):
	var targets = battle_manager.get_possible_targets(actor, ability);
	for target: ActorController in targets:
		var button = Button.new();
		button.text = target.name;
		
		var targetScreenPosition = camera.unproject_position(target.position);
		(
			func ():
				var buttonPosition = Vector2(targetScreenPosition.x - (button.size.x / 2), targetScreenPosition.y - (button.size.y / 2));
				button.set_position(buttonPosition);
				pass
		).call_deferred();
		
		button.pressed.connect(func():
			battle_manager.actor_ability_targets_selected.emit(actor, ability, target);
			hide_menu();
			pass
		);
		
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

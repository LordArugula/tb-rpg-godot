extends Control;

@onready
var battle_manager: BattleManager = $"/root/Main/BattleManager";
@onready
var camera: Camera3D = $"/root/Main/Camera3D";

func _ready() -> void:
	battle_manager.actor_ability_selected.connect(_on_battle_manager_actor_ability_selected);
	battle_manager.actor_ability_unselected.connect(_on_battle_manager_actor_ability_unselected);
	
	hide_menu();
	pass


func _on_battle_manager_actor_ability_selected(actor: ActorController, ability: AbilityController):
	show_menu(actor, ability);
	grab_focus();
	pass


func _on_battle_manager_actor_ability_unselected(_actor: ActorController, _ability: AbilityController):
	hide_menu();
	pass


func show_menu(actor: ActorController, ability: AbilityController):
	var targetGroups: Array[AbilityTargetGroupFilter.TargetGroup] = battle_manager.get_possible_targets(actor, ability);
	
	for targetGroup in targetGroups:
		var button = Button.new();
		button.text = targetGroup.name;
		button.pressed.connect(func():
			battle_manager.confirm_ability_targets(actor, ability, targetGroup.targets);
			hide_menu();
			pass
		);

		var targetPosition = targetGroup.targets.reduce(func(acc, target): return acc + target.position, Vector3.ZERO);
		var avgPosition = targetPosition / targetGroup.targets.size();
		set_button_position.call_deferred(button, camera.unproject_position(avgPosition));
		self.add_child(button);
		pass

	show();
	
	pass


func hide_menu():
	for child in self.get_children():
		child.queue_free();
	
	hide();
	
	pass


func set_button_position(button: Button, targetPosition: Vector2):
	var offset = button.size / 2;
	button.set_position(targetPosition - offset);
	pass

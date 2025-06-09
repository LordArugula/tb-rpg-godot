extends Control;

@onready
var container: Control = $"StatsContainer";

@onready
var battle_manager: BattleManager = $"/root/Main/BattleManager";

@onready
var camera: Camera3D = $"/root/Main/Camera3D";

func _ready() -> void:
	battle_manager.actor_knocked_out.connect(_on_actor_knocked_out);
	battle_manager.actor_mouse_entered.connect(__on_actor_mouse_entered);
	battle_manager.actor_mouse_exited.connect(__on_actor_mouse_exited);

	hide_menu();
	pass


func __on_actor_mouse_entered(actor: ActorController):
	show_menu(actor);
	pass


func __on_actor_mouse_exited(_actor: ActorController):
	hide_menu();
	pass


func _on_actor_knocked_out(_actor: ActorController):
	hide_menu();
	pass


func show_menu(actor: ActorController):
	for statKey in actor.stats.stats:
		var statControl = HBoxContainer.new();
		
		var stat = actor.stats.get_stat(statKey);
		
		var statLabel = Label.new();
		statLabel.text = statKey;
		var statValue = Label.new();
		statValue.text = "%.0d" % stat.value;
		statControl.add_child(statLabel);
		statControl.add_child(statValue);

		container.add_child(statControl);
		pass

	set_menu_position.call_deferred(container, camera.unproject_position(actor.position));
	
	pass


func hide_menu():
	for child in container.get_children():
		child.queue_free();
	
	hide();
	pass


func set_menu_position(menu: Control, targetPosition: Vector2):
	var offset = menu.size / 2;
	menu.set_position(targetPosition - offset);
	show();
	pass

extends Node3D;

class_name ActorController;

@export
var faction: StringName;

@onready
var abilities: AbilitySet = $AbilitySet;

@onready
var stats: StatSet = $StatSet;

@onready
var animation_player: AnimationPlayer = $AnimationPlayer;

@onready
var character_body: CharacterBody3D = $"CharacterBody3D";

func _ready():
	character_body.mouse_entered.connect(_on_mouse_entered);
	character_body.mouse_exited.connect(_on_mouse_exited);
	pass


func start_turn():
	turn_started.emit(self);
	pass


func end_turn():
	turn_ended.emit(self);
	pass


func activate_ability(ability: AbilityController, targets: Array[ActorController]):
	ability.activate(self, targets);
	ability.apply(self, targets);
	ability.resolve(self, targets);

	pass


func play_animation(animation: StringName):
	if (animation.is_empty()):
		return ;

	animation_player.play(animation);
	pass


func take_damage(amount: float):
	var mitigation = get_damage_mitigation();
	var damage = max(amount - mitigation, 0);

	var health = stats.get_stat(&"Health");
	health.value -= damage;

	damage_taken.emit(self, damage);

	if health.value <= 0:
		knocked_out.emit(self);
		pass

	pass


func take_healing(amount: float):
	var health = stats.get_stat(&"Health");
	health.value += amount;

	healing_taken.emit(self, amount);

	pass


func get_base_damage() -> float:
	var level = stats.get_stat(&"Level");
	var attack = stats.get_stat(&"Attack");

	return level.value * attack.value;


func get_damage_mitigation() -> float:
	var level = stats.get_stat(&"Level");
	var defense = stats.get_stat(&"Defense");

	return level.value * defense.value / 2;


func _on_mouse_entered():
	mouse_entered.emit(self);
	pass


func _on_mouse_exited():
	mouse_exited.emit(self);
	pass


signal turn_started(actor: ActorController);
signal turn_ended(actor: ActorController);

signal damage_taken(actor: ActorController, amount: float);
signal healing_taken(actor: ActorController, amount: float);
signal knocked_out(actor: ActorController);

signal mouse_entered(actor: ActorController);
signal mouse_exited(actor: ActorController);

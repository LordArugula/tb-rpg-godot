extends Node3D;

class_name ActorController;

@export
var stats: Dictionary[String, float] = {
};

var abilities: Array[AbilityController];

@onready
var animation_player = $AnimationPlayer;

func _ready():
	abilities.assign(get_children().filter(func(child): return child is AbilityController));
	
	pass


func start_turn():
	turn_started.emit(self);

	var ability = await ability_selected;
	if (ability == null):
		return ;
	
	print("%s selected %s" % [self.name, ability.name]);
	
	var targets: Array[ActorController] = [];
	targets.assign(await targets_selected);
	
	print("%s used %s on %s" % [self.name, ability.name, targets]);
	
	activate_ability(ability, targets);

	turn_ended.emit(self);

	pass


func activate_ability(ability: AbilityController, targets: Array[ActorController]):
	ability.activate(self, targets);
	ability.apply(self, targets);
	ability.resolve(self, targets);

	pass


func play_animation(animation: StringName):
	if (animation.is_empty()):
		return;

	animation_player.play(animation);
	pass


signal turn_started(actor: ActorController);
signal turn_ended(actor: ActorController);
signal ability_selected(ability: AbilityController);
signal targets_selected(targets: Array[ActorController]);

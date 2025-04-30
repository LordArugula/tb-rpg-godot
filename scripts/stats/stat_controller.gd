extends Node

class_name StatController;

@export
var base_value: float;

@export
var value: float;

var modifiers: Array[StatModifier];

func _ready():
    modifiers.assign(get_children().filter(func(child): return child is StatModifier));
    compute();

    pass


func compute():
    for modifier in modifiers:
        value = modifier.modify(base_value, value);
        pass

    pass


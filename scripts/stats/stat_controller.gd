extends Node

class_name StatController;

@export
var base_value: float;

var value: float;

var modifiers: Array[StatModifier];

func _ready():
    modifiers.assign(get_children().filter(func(child): return child is StatModifier));
    compute();

    pass


func compute():
    value = base_value;
    for modifier in modifiers:
        value = modifier.modify(base_value, value);
        pass

    pass


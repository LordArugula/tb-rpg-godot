extends Node;

class_name StatModifier;

func modify(_base_value: float, _current_value: float) -> StatValues:
	push_error("Function not implemented.");
	return StatValues.new(_base_value, _current_value);

class StatValues:
	var base: float;
	var current: float;

	func _init(base_value: float, current_value: float) -> void:
		self.base = base_value;
		self.current = current_value;
		pass

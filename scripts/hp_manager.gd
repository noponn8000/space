class_name HealthManager;
extends Node;

signal health_changed (int);
signal health_depleted;

@export var max_hp := 5;
@export var hp := max_hp: set = set_hp;

func set_hp(new_hp: int) -> void:
	new_hp = clamp(new_hp, 0, max_hp);
	hp = new_hp;

	if new_hp == 0:
		health_depleted.emit();
	else:
		health_changed.emit(hp);

func change_hp(delta: int) -> void:
	set_hp(hp + delta);

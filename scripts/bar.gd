class_name Bar
extends Control

@export var max_value: float;
@export var current_value: float;

@export var bar_sprite: Sprite2D;

func set_value(value: float) -> void:
	var delta := 1 / max_value * bar_sprite.texture.get_size().x;
	
	bar_sprite.region_rect.size.x = value * delta;
	bar_sprite.position.x = (bar_sprite.region_rect.size.x - bar_sprite.texture.get_size().x) / 2;

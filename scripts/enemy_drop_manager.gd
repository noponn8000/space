class_name EnemyDropManager;
extends Node2D;

@export var item_scene: PackedScene = load("res://scenes/coin.tscn");
@export var drop_min := 2;
@export var drop_max := 10;
@export var offset_range := 15.0;

func drop() -> void:
	var quantity = randi_range(drop_min, drop_max);
	
	for i in range(quantity):
		var item = item_scene.instantiate();
		item.global_position = global_position + Vector2(
			randf_range(-offset_range, offset_range),
			randf_range(-offset_range, offset_range)
		);
		get_tree().root.call_deferred("add_child", item);

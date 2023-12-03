class_name ItemManager;
extends Node

var current_item: ItemType.Type: set = _set_current_item;

var item_quantities := {
	ItemType.Type.BasicProjectile: -1,
	ItemType.Type.BouncyProjectile: 10,
	ItemType.Type.Bomb: 5
};

signal item_changed (int);

func _ready() -> void:
	Global.item_manager = self;
	
	current_item = ItemType.Type.BasicProjectile;

func set_item_quantity(item: ItemType.Type, quantity: int) -> void:
	quantity = clamp(quantity, 0, 100);
	
	if current_item == item:
		Global.hud.item_holder.set_item(item, quantity);
		
	item_quantities[item] = quantity;
	
func change_item_quantity(item: ItemType.Type, delta: int) -> void:
	if item_quantities[item] != -1:
		var quantity = clamp(item_quantities[item] + delta, 0, 100);
	
		set_item_quantity(item, quantity);
	
func decrement_item_quantity(item: ItemType.Type) -> void:
	change_item_quantity(item, -1);
	
func _set_current_item(item: ItemType.Type) -> void:
	current_item = item;
	
	if Global.hud:
		Global.hud.item_holder.set_item(item, item_quantities[item]);
		
func _on_item_used() -> void:
	decrement_item_quantity(current_item);
	
func get_current_item_quantity() -> int:
	return item_quantities[current_item];
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("item_back"):
		var item_index = item_quantities.keys().find(current_item);
		
		item_index = item_index - 1 if item_index >= 1 else len(item_quantities) - 1;
		current_item = item_quantities.keys()[item_index];

		item_changed.emit(current_item);
	elif Input.is_action_just_pressed("item_forward"):
		var item_index = item_quantities.keys().find(current_item);
		
		item_index = item_index + 1 if item_index < len(item_quantities) - 1 else 0;
		current_item = item_quantities.keys()[item_index];

		item_changed.emit(current_item);

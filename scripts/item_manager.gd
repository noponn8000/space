class_name ItemManager;
extends Node

var current_item: ItemType: set = _set_current_item;

var item_quantities := {
	ItemType.BasicProjectile: -1,
	ItemType.BouncyProjectile: 10,
	ItemType.Bomb: 5
};

func _ready() -> void:
	Global.item_manager = self;

func set_item_quantity(item: ItemType, quantity: int) -> void:
	quantity = clamp(quantity, 0, 100);
	
	if current_item == item:
		Global.hud.item_holder.set_item(item, quantity);
		
	item_quantities[item] = quantity;
	
func decrement_item_quantity(item: ItemType) -> void:
	set_item_quantity(item, item_quantities[item] - 1);
	
func _set_current_item(item: ItemType) -> void:
	current_item = item;
	
	Global.hud.item_holder.set_item(item, item_quantities[item]);

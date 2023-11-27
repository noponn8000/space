extends Control

@onready var item_sprite: Sprite2D = $ItemSprite

@export var quantity_label: Label;

func set_item(item: ItemType.Type, quantity: int) -> void:
	item_sprite.texture = Global.item_sprites[item];
	
	if quantity == -1:
		quantity_label.text = "∞";
	else:
		quantity_label.text = str(quantity);

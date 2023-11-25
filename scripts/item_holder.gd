extends Control

@onready var item_sprite: Sprite2D = $ItemSprite

@export var quantity_label: Label;

var item_dict := {
	ItemType.BouncyProjectile: preload("res://assets/bounce_bullet.png"),
	ItemType.Bomb: preload("res://assets/bomb.png")
}

func set_item(item: int, quantity: int) -> void:
	item_sprite.texture = item_dict[item];
	
	if quantity == -1:
		quantity_label.text = "";
	else:
		quantity_label.text = str(quantity);

extends Interactable;

@export var price := 10;
@export var item: ItemType.Type;
@export var quantity := 5;

@onready var item_sprite: Sprite2D = $ItemSprite
@onready var quantity_label := $QuantityLabel;
@onready var price_label: Label = $PriceLabel
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	item_sprite.texture = Global.item_sprites[item];
	quantity_label.text = str(quantity);
	price_label.text = str(price);
	
func interact() -> void:
	if Global.coin_manager.coin_count > price and quantity >= 0:
		Global.item_manager.change_item_quantity(item, 1);
		Global.coin_manager.change_coin_count(-price);
		
		quantity -= 1;
		quantity_label.text = str(quantity);
		audio_stream_player_2d.play();

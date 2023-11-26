class_name CoinPickupManager;
extends Area2D

signal coin_collected;

func _ready() -> void:
	area_entered.connect(_on_area_entered);
	
func _on_area_entered(other: Area2D) -> void:
	var coin = other as Coin;
	
	if coin:
		coin.pick_up();
		
		Global.coin_manager.add_coin();
		coin_collected.emit();

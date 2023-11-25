extends Node

const item_library := {
	ItemType.BasicProjectile: preload("res://scenes/basic_projectile.tscn"),
	ItemType.BouncyProjectile: preload("res://scenes/bouncy_projectile.tscn"),
	ItemType.Bomb: preload("res://scenes/bomb_projectile.tscn")
};
	
var player: Player;
var hud: HUD;
var camera: Camera2D;
var item_manager: ItemManager;
var coin_count := 0;

func add_coin() -> void:
	coin_count += 1;

	hud.update_coin_count(coin_count);

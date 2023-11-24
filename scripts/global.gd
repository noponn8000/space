extends Node

var player: Player;
var hud: HUD;
var camera: Camera2D;
var coin_count := 0;

func add_coin() -> void:
	coin_count += 1;
	
	hud.update_coin_count(coin_count);

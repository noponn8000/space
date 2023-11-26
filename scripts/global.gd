extends Node

const item_library := {
	ItemType.Type.BasicProjectile: preload("res://scenes/basic_projectile.tscn"),
	ItemType.Type.BouncyProjectile: preload("res://scenes/bouncy_projectile.tscn"),
	ItemType.Type.Bomb: preload("res://scenes/bomb_projectile.tscn")
};

const item_sprites := {
	ItemType.Type.BasicProjectile: preload("res://assets/bullet_template.png"),
	ItemType.Type.BouncyProjectile: preload("res://assets/bounce_bullet.png"),
	ItemType.Type.Bomb: preload("res://assets/bomb.png")
}
	
var player: Player;
var hud: HUD;
var camera: Camera2D;
var item_manager: ItemManager;
var coin_manager: CoinManager;

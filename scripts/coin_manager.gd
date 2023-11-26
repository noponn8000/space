class_name CoinManager;
extends Control

var coin_count := 0;

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	Global.coin_manager = self;
	
func change_coin_count(delta: int) -> void:
	coin_count = max(coin_count + delta, 0);
	update_coin_display();
	
func add_coin() -> void:
	change_coin_count(1);
	
func update_coin_display() -> void:
	label.text = str(coin_count);
	animation_player.play("shake");

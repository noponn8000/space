class_name HUD;
extends CanvasLayer;

@onready var label: Label = $Control/Label;
@onready var thruster_bar := $ThrusterBar;
@onready var item_holder: Control = $ItemHolder

func _ready() -> void:
	Global.hud = self;
	
func update_coin_count(coin_count: int) -> void:
	label.text = str(coin_count);

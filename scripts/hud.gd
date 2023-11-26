class_name HUD;
extends CanvasLayer;

@onready var thruster_bar := $ThrusterBar;
@onready var item_holder: Control = $ItemHolder

func _ready() -> void:
	Global.hud = self;
	
	Global.item_manager.current_item = ItemType.Type.BasicProjectile;

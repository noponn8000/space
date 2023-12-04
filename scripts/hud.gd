class_name HUD;
extends CanvasLayer;

@onready var thruster_bar := $ThrusterBar;
@onready var item_holder: Control = $ItemHolder
@onready var health_display: Control = $HealthDisplay
@onready var dialogue_panel: DialoguePanel = $DialoguePanel

func _ready() -> void:
	Global.hud = self;
	
	Global.item_manager.current_item = ItemType.Type.BasicProjectile;
	Global.player_hp.health_changed.connect(health_display.set_cell_number);

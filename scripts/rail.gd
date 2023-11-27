@tool
extends Path2D

@onready var line: Line2D = $Line2D;
 
func _ready() -> void:
	update_display();
	
func update_display() -> void:
	line.points = curve.get_baked_points();

func _process(_delta: float)  -> void:
	if Engine.is_editor_hint():
		update_display();

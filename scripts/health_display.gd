class_name HealthDisplay
extends Control

@export var max_cells := 5;
@export var current_cells := max_cells: set = set_cell_number;
@export var cell_spacing := 50.0;
@export var cell_scene := load("res://scenes/energy_cell.tscn");

var cells := [];

func _ready() -> void:
	for i in range(max_cells):
		var cell = cell_scene.instantiate();

		add_child(cell);
		cell.position += Vector2(i * cell_spacing, 0);
		
		cells.append(cell);
	current_cells = max_cells;
		
func set_cell_number(n: int) -> void:
	if not cells:
		return;
	n = clamp(n, 0, max_cells);
	
	for i in range(max_cells):
		if i < n:
			cells[i].active = true;
		else:
			cells[i].active = false;

func set_max_cells(n: int) -> void:
	if n > max_cells:
		for i in range(n - max_cells):
			var cell = cell_scene.instantiate();

			add_child(cell);
			cell.position += Vector2(max_cells + i * cell_spacing, 0);

			cells.append(cell);

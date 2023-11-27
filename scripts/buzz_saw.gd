extends PathEnemy;

@export var rotation_speed := 10.0;

func _physics_process(delta: float) -> void:
	super._physics_process(delta);
	
	rotation += rotation_speed * delta;

class_name Hitbox;
extends Area2D;

signal hit_registered (Hurtbox);

func _ready() -> void:
	area_entered.connect(_on_area_entered);
	
func _on_area_entered(other: Area2D) -> void:
	var hurtbox = other as Hurtbox;
	
	if hurtbox:
		hurtbox.register_hit(self);
		
		hit_registered.emit(hurtbox);

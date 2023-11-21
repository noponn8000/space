class_name Hurtbox;
extends Area2D

signal hit_registered(hitbox: Hitbox);

func register_hit(hitbox: Hitbox) -> void:
	hit_registered.emit(hitbox);

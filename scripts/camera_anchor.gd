class_name CameraAnchor;
extends Area2D

signal anchor_activated(CameraAnchor);

@export var zoom := Vector2.ONE;

func _ready() -> void:
	body_entered.connect(_on_body_entered);
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		anchor_activated.emit(self);

class_name CameraAnchor;
extends Area2D

signal anchor_activated(CameraAnchor);

@export var zoom := Vector2.ONE;
@export var visited := false;
@export var occlusion_sprite: ColorRect;
@export var collision_shape: CollisionShape2D;

func _ready() -> void:
	body_entered.connect(_on_body_entered);
	
	if occlusion_sprite:
		occlusion_sprite.size = collision_shape.shape.size;
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		anchor_activated.emit(self);
		
		if not visited:
			visited = true;
			
			animate_reveal();
			
func animate_reveal() -> void:
	if occlusion_sprite:
		var tween := get_tree().create_tween();
		
		tween.tween_property(occlusion_sprite, "modulate", Color.TRANSPARENT, 0.5).set_trans(Tween.TRANS_CUBIC);

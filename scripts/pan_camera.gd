class_name CameraPanner;
extends Node;

@export var camera: Camera2D
@export var anchor_node: Node2D;
@export var pan_speed := 0.5;

var anchors: Array[CameraAnchor] = [];

func _ready() -> void:
	for anchor in anchor_node.get_children():
		anchor = anchor as CameraAnchor;
		if anchor:
			anchors.append(anchor);
			anchor.anchor_activated.connect(_on_anchor_changed);
			
func _on_anchor_changed(anchor: CameraAnchor) -> void:
	var tween = get_tree().create_tween();
	
	tween.set_parallel(true);
	tween.tween_property(camera, "global_position", anchor.global_position, pan_speed).set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(camera, "zoom", anchor.zoom, pan_speed).set_trans(Tween.TRANS_CUBIC);

class_name CameraPanner;
extends Node;

@export var camera: Camera2D
@export var anchor_node: Node2D;
@export var pan_speed := 0.5;

var anchors: Array[CameraAnchor] = [];
var current_anchor: CameraAnchor = null;
var free_cam := false;
@onready var camera_parent := camera.get_parent();

func _ready() -> void:
	Global.player.visibility_notifier.screen_exited.connect(_on_player_screen_exited);
	
	for anchor in anchor_node.get_children():
		anchor = anchor as CameraAnchor;
		if anchor:
			anchors.append(anchor);
			anchor.anchor_activated.connect(_on_anchor_changed);
			
func _on_anchor_changed(anchor: CameraAnchor) -> void:
	camera.reparent(camera_parent);
	current_anchor = anchor;
	free_cam = false;
	camera.position_smoothing_enabled = false;
	var tween = get_tree().create_tween();
	
	tween.set_parallel(true);
	tween.tween_property(camera, "global_position", anchor.global_position, pan_speed).set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(camera, "zoom", anchor.zoom, pan_speed).set_trans(Tween.TRANS_CUBIC);

func _on_player_screen_exited() -> void:
	if free_cam:
		return;
	# Flags
	free_cam = true;
	camera.reparent(Global.player);
	camera.position = Vector2.ZERO;
	
	# Tween the position change
	var tween = get_tree().create_tween();
	
	tween.set_parallel(true);
	tween.tween_property(camera, "global_position", Global.player.global_position, pan_speed).set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(camera, "zoom", Vector2(3, 3), pan_speed).set_trans(Tween.TRANS_CUBIC);

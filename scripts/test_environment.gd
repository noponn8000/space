extends Node2D

func _init() -> void:
	Global.set_script(null);
	Global.set_script(preload("res://scripts/global.gd"));

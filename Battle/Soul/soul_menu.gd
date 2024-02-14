@icon("res://Battle/Soul/soul.png")
extends Node2D
class_name SoulMenu

const TIME: float = 0.2
var enabled := true

var movetween: Tween

@export var soul_type := SoulBattle.soul_types.SOUL_HUMAN

func _ready() -> void:
	$Sprite.modulate = Color(1, 1, 1, 1) if soul_type == SoulBattle.soul_types.SOUL_MONSTER else Color(1, 0, 0 , 1)
	#$Sprite.animation = &"directions" if soul_type == SoulBattle.soul_types.SOUL_HUMAN else &"directions_m"

var _able_tween: Tween

func enable() -> void:
	if !enabled:
		enabled = true
		if !is_node_ready(): await ready
		print(Global.player_position)
		position = Global.player_position #Vector2(320, 454)
		modulate.a = 1
		#_able_tween = create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
		#_able_tween.tween_property(self, "modulate:a", 1, 0.2)

func _enter_tree() -> void:
	enable()

func disable() -> void:
	if enabled:
		enabled = false
		_able_tween = create_tween()
		_able_tween.tween_property(self, "modulate:a", 0, 0.2)
		_able_tween.tween_callback(get_parent().remove_child.bind(self)).set_delay(0.05)

func _on_movesoul(newpos: Vector2) -> void:
	if movetween and movetween.is_valid():
		movetween.kill()
	if is_inside_tree():
		movetween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT).set_parallel()
		movetween.tween_property(self, "position", newpos, TIME)
		#movetween.tween_property(self, "scale", Vector2.ZERO, 0.01)
		#movetween.chain().tween_callback(set_position.bind(newpos))
		#movetween.tween_property(self, "scale", Vector2.ONE, TIME * 2)




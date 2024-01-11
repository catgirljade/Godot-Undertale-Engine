extends Control

@onready var Text = $Hp
@onready var Bar = $Bar

var time = 0.7
var hp = 20
var max_hp = 50
var damage = 0
var miss = false

signal finished
signal damagetarget
func _ready() -> void:
	modulate.a = 0
	Bar.max_value = max_hp
	Bar.value = hp
	await get_tree().process_frame
	Bar.size.x = min(100 + max_hp/5.0,560)
	Bar.position.x = -Bar.size.x/2.0
	if miss:
		Text.text = "[center][color=gray]MISS"
	elif damage >0:
		$Hit.play()
		Text.text = "[center][color=red]"+ str(damage)
		emit_signal("damagetarget",damage)
	else:
		$Hit.play()
		emit_signal("damagetarget",damage)
		Text.text = "[center][color=gray]BLOCKED"
	var tw = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.tween_property(Text,"position:y",-10,time).as_relative()
	tw.tween_property(self,"modulate:a",1,time/8.0)
	tw.tween_property(Bar,"value",-damage,time/2.0).as_relative()
	tw.chain()
	tw.tween_property(Text,"position:y",10,time).as_relative().set_ease(Tween.EASE_IN)
	tw.tween_property(self,"modulate:a",0,time/8.0).set_delay(time*7.0/8.0)
	await tw.finished
	emit_signal("finished")

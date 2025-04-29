@icon("res://editor/icons/horse.png")
extends CharacterBody2D
class_name Horse
## The main class of the horses
##
## Used for anything horse related, designed in a way so you can make a race with writing no code

## The name of the horse[br]
## Appears at the victory screen when the horse wins
@export_placeholder("Door Knob") var Name:String

## The shortened name of the horse[br]
## Appears at the start of the round
@export_placeholder("KNB") var ShortName:String

## The color of the horse
@export var HorseColor:Color = Color.SADDLE_BROWN

## Affects the likelyhood of the horse doing a random ass move that does not follow the laws of physics[br]
## Allows for situations like 1:21 of [url=https://x.com/snakesandrews/status/1911598089690919052]e1m4t1p3[/url][br][br]
## If this variable is 0, then the horse does no random moves UNLESS its stuck in place[br]
## If this variable is 10, then the horse does only random moves[br]
## I don't recommend setting this variable anywhere below 5, it can cause the horse to be stuck for a while
@export_range(0, 10, 0.1) var BrainDamage:float = 5

@export_category("Nodes")
@export var SpriteNode:Sprite2D
@export var BounceSoundNode:AudioStreamPlayer
@export var BounceTimerNode:Timer

const speed = 250

var can_move:bool = false
var can_play_bounce_sound:bool = true

func _ready():
	GameHandler.game_started.connect(_on_game_started)
	_init_horse()
	get_random_velocity()

func _process(delta: float) -> void:
	if !can_move:
		return
	
	if velocity == Vector2(0.0, 0.0):
		get_random_velocity()
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if can_play_bounce_sound:
			BounceSoundNode.play()
			can_play_bounce_sound = false
			BounceTimerNode.start()
		if BrainDamage == 0:
			velocity = velocity.bounce(collision.get_normal())
			return
		elif BrainDamage == 10:
			do_braindead_move(10)
			return
		
		
		var braindead_move = randi_range(1, 10)
		if braindead_move <= BrainDamage:
			do_braindead_move(braindead_move)
			return
		
		velocity = velocity.bounce(collision.get_normal())

func _init_horse():
	if ShortName == null:
		push_warning("A horse has no short name")
	
	if Name == null:
		push_warning("A horse has no name")
	
	if SpriteNode == null:
		push_error("A horse has no sprite!")
	
	
	SpriteNode.material.set("shader_parameter/target_color", Color("00bc00"))
	SpriteNode.material.set("shader_parameter/replace_color", Vector3(HorseColor.r, HorseColor.g, HorseColor.b))

func _on_game_started():
	can_move = true

func get_random_velocity():
	velocity = Vector2(randf_range(-speed, speed), randf_range(-speed, speed))

func do_braindead_move(_braindead_move):
	#print("%s did a braindead move (%s/%s)" % [Name, BrainDamage, _braindead_move])
	get_random_velocity()

func _on_bouncetimer_timeout() -> void:
	can_play_bounce_sound = true

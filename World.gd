extends Node2D

onready var hud = $HUD
onready var obstacle_spwaner = $obstaclespwaner
onready var ground = $Ground
onready var menu_layer = $Menulayer
onready var piont = $Piont

const Save_File_Path = "user://savedata.save"

var score = 0 setget set_score
var highscore = 0

func _ready(): #NO ERROR
	obstacle_spwaner.connect("obstacle_created", self, "_on_obstacle_created")
	load_highscore()

func new_game():
	self.score = 0
	obstacle_spwaner.start()


func player_score():
	self.score +=1
	piont.play()
	#print("everything 's good")

func set_score(new_score): #NO ERROR
	score = new_score
	hud.update_score(score)
	#print("everything 's good")

func _on_obstacle_created(obs):#NO ERROR
	obs.connect("score", self, "player_score")
	#print("everything 's good")


func _on_deathzone_body_entered(body):
	if body is Player:
		body.has_method("die")
		body.die()
		
func _on_Player_died():
	game_over()
	
	
func game_over():
	obstacle_spwaner.hide()			
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacle", "set_physics_process", false)	
	
	if score > highscore:
		highscore = score
		save_highscore()
	menu_layer.init_game_over_menu(score, highscore)

func _on_Menulayer_start_game():
	new_game()
	
func save_highscore():
	var save_data = File.new()
	save_data.open(Save_File_Path, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()
	
func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(Save_File_Path):
		save_data.open(Save_File_Path, File.READ)
		highscore = save_data.get_var()
		save_data.close()

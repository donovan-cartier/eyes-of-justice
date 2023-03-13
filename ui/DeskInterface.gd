extends Control

@onready var player = get_tree().get_nodes_in_group("player")[0]
@onready var player_inventory = player.get_node('Inventory')

#Start using desk
func start():
	show()
	check_can_place_item()
	
	#Enable mouse cursor
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
#Stop using desk
func stop():
	hide()
	
	#Enable mouse cursor
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	get_parent().stop_interact()



func check_can_place_item():
	if player_inventory.has_item(get_parent().item_to_place):
		$PlaceItem.disabled = false

func _on_return_pressed():
	stop()

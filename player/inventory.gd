extends Node

@export var inventory : Array[String]

#Add item to inventory
func add_item(item_name: String):
	inventory.append(item_name)
	print("new inventory : " + str(inventory))

#Remove item from inventory using item name
func remove_item(item_name: String):
	inventory.erase(item_name)
	
#Remove item from inventory using item ID
func remove_item_by_id(id: int):
	print(id)

#Remove item from inventory using item position in array
func remove_item_at_index(index: int):
	inventory.remove_at(index)

#Return if inventory contains item_name or not
func has_item(item_name: String):
	print("has:" + item_name)
	return inventory.has(item_name)

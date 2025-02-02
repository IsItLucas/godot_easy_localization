@tool
@icon("res://addons/easy_translation/target/icon.png")
class_name NodeTarget extends Resource


## A resource that points to a node in the scene and one if its properties.
##
## This resource can be used by Translation and ReplaceableString nodes to determine
## what node and what property is going to be used for the operation of these nodes.


## The path to the desired target node.
@export var target_path: NodePath

## The target property in the target node.
@export var target_property: String


## Sets [member target_path] to [param new_path].
func set_target_path(new_path: NodePath) -> void:
	target_path = new_path


## Sets [member target_property] to [param new_property].
func set_target_property(new_property: String) -> void:
	target_property = new_property


## Returns the target path.
func get_target_path() -> String:
	return target_path


## Returns the target property.
func get_target_property() -> NodePath:
	return NodePath(target_property).get_as_property_path()


## Returns the target node as a Node instead of NodePath.
func get_target_node(from: Node) -> Node:
	# Get the target node using the dummy node.
	var target_node: Node = from.get_node_or_null(target_path)
	
	# Check if the node is valid.
	if not target_node:
		push_error("Could not get target node located at \"%s\"." % target_path)
		return null
	
	# Return the target node.
	return target_node


## Returns the value of the target node's [member target_property].
func get_value(from: Node) -> Variant:
	# Get target node.
	var target_node := get_target_node(from)
	
	# Check if node is valid.
	if not target_node:
		return null
	
	# Check if property is valid.
	var property_path: NodePath = NodePath(target_property).get_as_property_path()
	if not target_node.get_indexed(property_path):
		push_error("Could not get \"%s\" in \"%s\"." % [property_path, target_node.name])
		return null
	
	# Return the value of the target property.
	return target_node.get_indexed(property_path)

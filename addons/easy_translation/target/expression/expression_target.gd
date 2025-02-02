@tool
@icon("res://addons/easy_translation/target/expression/icon.png")
class_name ExpressionTarget extends NodeTarget


## An advanced version of NodeTarget.
##
## This resource can run code in a target node and use the result from that expression
## in a FormattableTranslationString, for example.
## Note: Doesn't work in the editor.


## The expression to run in the target node.
var expression: String = ""


func _get_property_list() -> Array[Dictionary]:
	# Create an empty array to store custom properties.
	var properties: Array[Dictionary] = []
	
	# Add custom properties to the array.
	properties.append({
		"name": "expression",
		"type": TYPE_STRING,
		"hint": PROPERTY_HINT_EXPRESSION,
	})
	
	# Return all custom properties.
	return properties


## Returns the value of the target node's [member target_property].
func get_value(from: Node) -> Variant:
	# Get target node.
	var target_node := get_target_node(from)
	
	# Check if node is valid.
	if not target_node:
		return null
	
	if Engine.is_editor_hint() or expression == "":
		# Check if property is valid.
		var property_path: NodePath = NodePath(target_property).get_as_property_path()
		if not target_node.get_indexed(property_path):
			push_error("Could not get \"%s\" in \"%s\"." % [property_path, target_node.name])
			return null
		
		# Return the value of the target property.
		return target_node.get_indexed(property_path)
	else:
		# Create a new expression.
		var code := Expression.new()
		
		# Parse the expression string.
		var error := code.parse(expression)
		
		# Check if parse failed.
		if error != OK:
			push_error("Could not parse expression. Error: %s." % error_string(error))
			return null
		
		# Execute.
		var result := code.execute([], self)
		
		# Check if execution failed.
		if code.has_execute_failed():
			push_error("Expression execution failed.")
			return null
		
		return result

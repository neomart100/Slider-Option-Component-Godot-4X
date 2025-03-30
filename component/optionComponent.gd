extends MarginContainer

var optionIndex:int  = 0
var maxOptions:int = 0
@export_category("Option Name")
#Option
@export var OptionName:String
@export_category("Option Array")
#Dictionary
@export var OptionArray:PackedStringArray
#Labels
@onready var nameLabel: Label = $HboxMainOption/marginName/nameLabel
@onready var optionLabel: Label = $HboxMainOption/MarginContainer/HboxOption/marginOption/optionLabel
#Buttons
@onready var buttonLeft: TextureButton = $HboxMainOption/MarginContainer/HboxOption/buttonLeft
@onready var buttonRight: TextureButton = $HboxMainOption/MarginContainer/HboxOption/buttonRight
#Visual indicator at the bottom
@onready var marginIndicator: MarginContainer = $HboxMainOption/MarginContainer/marginIndicator
@onready var HboxIndicator: HBoxContainer = $HboxMainOption/MarginContainer/marginIndicator/VboxSeparator/HBoxIndicator

##Signal that sends the Index to the interface
signal IDX(optionIndex)


func _ready() -> void:
	#Wait for everything to execute correctly
	await get_tree().process_frame
	#Initialize the selection of options
	selectOption(optionIndex)
	#Add the rectangles at the bottom of the option as a visual indicator
	forVisualIndicator()
	#Initialize selection of the visual indicator
	visualIndicator(optionIndex)
	#Maximum number of options the component will have
	#Minus 1 because for some reason there is always an empty space in packedArray
	#If you know why, tell me :D
	maxOptions = OptionArray.size() -1
	#Make the name label equal to OptionName from the inspector
	nameLabel.text = OptionName




##Function that contains the logic for the options slider
func selectOption(indice:int):
	if indice != null:
		optionIndex = indice
		if optionIndex != -1:
			##Iterate through the Array with the options
			for i in range(OptionArray.size()):
				#Pass the array with the selected option
				var SelectOptionArray = OptionArray[i]
				if i == optionIndex:
					#Display in the interface
					optionLabel.text = SelectOptionArray
					##Emit a signal with the Index to the desired node
					#to compare the IDX with a match and use it accordingly
					IDX.emit(optionIndex)
					print("the index is:", optionIndex)

#Logic that creates rectangles as visual indicators (e.g., ColorRect)
#at the bottom of the options
func forVisualIndicator():
	#The number of ColorRects equals the number of options
	for i in range(OptionArray.size()):
		##Create a rectangle of type Color to fill the marginIndicator/HboxIndicator
		var fillColorect:ColorRect = ColorRect.new()
		##Rectangle size
		fillColorect.custom_minimum_size = Vector2(8, 4)
		#Add to the HboxIndicator
		HboxIndicator.add_child(fillColorect)
		
#Logic to make the visual indicator match the selected option
func visualIndicator(indice):
	optionIndex = indice
	##Iterate through the HboxIndicator with all the ColorRects
	for i in range(HboxIndicator.get_child_count()):
		
		var visualrectangleIndicator = HboxIndicator.get_child(i)
		##Select an option and change the ColorRect color
		if i == indice:
			visualrectangleIndicator.modulate = Color("ffffff")
		##If not selected, make the color default
		else:
			visualrectangleIndicator.modulate = Color("9ba2c4")

#region Selection buttons
#LEFT
func _on_button_left_pressed() -> void:
	if optionIndex > 0:
		#Options 
		selectOption(optionIndex - 1)
		#Visual options indicator (bottom)
		visualIndicator(optionIndex)

#RIGHT
func _on_button_right_pressed() -> void:
	if optionIndex < maxOptions:
		#Options 
		selectOption(optionIndex + 1)
		#Visual options indicator (bottom)
		visualIndicator(optionIndex)
	
#endregion

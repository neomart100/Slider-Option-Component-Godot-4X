extends MarginContainer

var optionIndex:int  = 0
var maxOptions:int = 0
@export_category("Option Name")
#Opcion
@export var OptionName:String
@export_category("Option Array")
#Diccionario
@export var OptionArray:PackedStringArray
#Labels
@onready var nameLabel: Label = $HboxMainOption/marginName/nameLabel
@onready var optionLabel: Label = $HboxMainOption/MarginContainer/HboxOption/marginOption/optionLabel
#Bottones
@onready var buttonLeft: TextureButton = $HboxMainOption/MarginContainer/HboxOption/buttonLeft
@onready var buttonRight: TextureButton = $HboxMainOption/MarginContainer/HboxOption/buttonRight
#Indicadore visual en la parte Inferior
@onready var marginIndicator: MarginContainer = $HboxMainOption/MarginContainer/marginIndicator
@onready var HboxIndicator: HBoxContainer = $HboxMainOption/MarginContainer/marginIndicator/VboxSeparator/HBoxIndicator

##Señal que envia el Index a la interfaz
signal IDX(optionIndex)


func _ready() -> void:
	#Esperar a que todo se ejecute correctamente
	await get_tree().process_frame
	#inicializar la seleccion de las Opciones
	selectOption(optionIndex)
	#Agregamos los rectangulos en la parte inferior del la Opcion como indicador visual
	forVisualIndicator()
	#Incializar seleccion del indicador visual
	visualIndicator(optionIndex)
	#Maximo numero de OPciones que tendra el componente
	#Menos 1 por que por algun motivo siempre queda un espacio vacio en packedArray
	#Si sabes por que dimero :D
	maxOptions = OptionArray.size() -1
	#Hacemos que el name label sea igual OptionName del inspector
	nameLabel.text = OptionName




##Funcion que contiene la logica para el slider de Opciones
func selectOption(indice:int):
	if indice != null:
		optionIndex = indice
		if optionIndex != -1:
			##Recorremos el Array con las Opciones
			for i in range(OptionArray.size()):
				#pasamos el Array con la Opcion seleccionada
				var SelectOptionArray = OptionArray[i]
				if i == optionIndex:
					#imprimios en la interfaz
					optionLabel.text = SelectOptionArray
					##Emitir señal con el Index hacia el nodo que quieras para
					#comparar el IDX con un match y asi usarlo
					IDX.emit(optionIndex)
					print("el index es:", optionIndex)

#Logica que hace que haya rectangulos como indicadores visuales tipo colorRect
#en la parte inferior de las Opciones
func forVisualIndicator():
	#el numero de colorect sea igual al numero de Opciones
	for i in range(OptionArray.size()):
		##crear rectangulo tipo color  para rellenar el marginIndicator/HboxIndicator
		var fillColorect:ColorRect = ColorRect.new()
		##Tamaño del rectangulo 
		fillColorect.custom_minimum_size = Vector2(8, 4)
		#Agregados al HboxIndicator
		HboxIndicator.add_child(fillColorect)
		
#logica para que el indicador visual sea a corde a la Opcion seleccionada
func visualIndicator(indice):
	optionIndex = indice
	##Recorre el HboxIndicator con todos los coloreRects
	for i in range(HboxIndicator.get_child_count()):
		
		var visualrectangleIndicator = HboxIndicator.get_child(i)
		##Seleccionar una Opcion y cambiar el color del color rect
		if i == indice:
			visualrectangleIndicator.modulate = Color("ffffff")
		##Si no esta seleccionado hacer que el color  sea por defecto
		else:
			visualrectangleIndicator.modulate = Color("9ba2c4")

#region Botones de seleccion
#LEFT
func _on_button_left_pressed() -> void:
	if optionIndex > 0:
		#Opciones 
		selectOption(optionIndex - 1)
		#indicador visual de Opciones(parte inferior)
		visualIndicator(optionIndex)

#RIGHT
func _on_button_right_pressed() -> void:
	if optionIndex < maxOptions:
		#Opciones 
		selectOption(optionIndex + 1)
		#indicador visual de Opciones(parte inferior)
		visualIndicator(optionIndex)
	
#endregion

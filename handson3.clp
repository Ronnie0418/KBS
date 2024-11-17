(defrule inicializarEnfermedades
   =>
   (printout t "Inicializando las enfermedades" crlf)

   ; Enfermedades y sus respectivos signos y síntomas
   (assert (enfermedad dengue erupcionCutanea respiracionAcelerada fiebreAlta dolorMuscular))
   (assert (enfermedad diabetes sediento fatiga visionBorrrosa aumentoHambre))
   (assert (enfermedad covid fatiga tosSeca fiebre perdidaDelOlfato))
   (assert (enfermedad tuberculosis tosPersistente fatiga fiebre perdidaDePeso))
   (assert (enfermedad asma dificultadRespiratoria sibilancias tos opresionPecho))
   (assert (enfermedad gripe fiebre tos dolorDeGarganta cansancio))
   (assert (enfermedad artritis dolorArticular dolorHuesos inflamacion rigidez))
   (assert (enfermedad hepatitis amarillez fatiga dolorAbdomen perdidaAppetit))
   (assert (enfermedad neumonia dificultadRespiratoria coloracionEnPiel tosSanguinolenta fiebreAlta))
   (assert (enfermedad infartoDolor pecho dolorBrazoIzq dificultadRespiratoria sudoracionExcesiva))

   (printout t "Enfermedades inicializadas correctamente." crlf)
)

(defrule consultarEnfermedades
    (accion consultar)
    (enfermedad ?nombre ?signo1 ?signo2 ?sintoma1 ?sintoma2)
    =>
    (printout t "Enfermedad: " ?nombre crlf)
    (printout t "  Signos: " ?signo1 " y " ?signo2 crlf)
    (printout t "  Síntomas: " ?sintoma1 " y " ?sintoma2 crlf)
    (printout t "---------------------------------------------------" crlf)
)

(defrule eliminarEnfermedad
    (accion eliminar ?nombreEliminar)
    ?f <- (enfermedad ?nombreEliminar ?signo1 ?signo2 ?sintoma1 ?sintoma2)
    =>
    (printout t "Eliminando la enfermedad: " ?nombreEliminar crlf)
    (retract ?f)
    (printout t "Enfermedad eliminada correctamente." crlf)
)

(defrule agregarEnfermedad
    (accion agregar ?nombre ?signo1 ?signo2 ?sintoma1 ?sintoma2)
    =>
    (assert (enfermedad ?nombre ?signo1 ?signo2 ?sintoma1 ?sintoma2))
    (printout t "Enfermedad agregada: " ?nombre crlf)
)


;TP Funcional Albarenque Junior - Godoy Matías - Lencina Federico - Palacios Angel
#lang racket

;1)Lista de listas con cada una de las localidades, sus costos y horarios de salidas
(define itinerario
  (list
    (list "Córdoba Capital" 1500 (list (list 07 00) (list 10 00) (list 12 00)))
    (list "Carlos Paz" 1500 (list (list 07 30) (list 10 30) (list 12 30)))
    (list "Bialet Massé" 1000 (list (list 07 45) (list 10 45) (list 12 45)))
    (list "Valle Hermoso" 1200 (list (list 08 15) (list 11 15) (list 13 15)))
    (list "La Falda" 1000 (list (list 08 30) (list 11 30) (list 13 30)))
    (list "Huerta Grande" 1200 (list (list 08 45) (list 11 45) (list 13 45)))
    (list "La Cumbre" 1600 (list (list 09 30) (list 12 30) (list 14 30)))
    (list "Capilla Del Monte" 0 (list (list 10 00) (list 13 00) (list 15 00))) ; Costo 0, debido a que no es un punto de salida
  ))

;2)Función que recibe una localidad y devuelve la lista correspondiente a esa localidad
;   (localidad, costo, horarios)
;   si la localidad no se encuentra en el itinerario devuelve "ERROR"
(define (buscar_detalle_localidad localidad)
  (letrec ([buscar-localidad (lambda (lst)
                               (cond
                                 [(null? lst) "ERROR"]
                                 [(equal? (car (car lst)) localidad) (car lst)]
                                 [else (buscar-localidad (cdr lst))]))])
    (buscar-localidad itinerario)))

;3)Función que recibe una localidad y los horarios de salida de esa localidad
(define (horarios localidad)
 (car(cdr(cdr (buscar_detalle_localidad localidad)))))

;4)Función que recibe dos horas y devuelve true si la primera hora es menor o igual a la segunda
(define (hora_valida hora_consulta hora_salida)
  (cond
    [(< (car hora_consulta) (car hora_salida)) #t]
    [(and (= (car hora_consulta) (car hora_salida)) (<= (cadr hora_consulta) (cadr hora_salida))) #t]
    [else #f]))

;5)Función que recibe dos localidades y devuelve un subconjuto de itenerario
;   que contiene las localidades entre localidad1 y el fin de itinerario
;   si localidad1 no se encuentra en el itinerario devuelve "ERROR"
;   si localidad2 se encuentra en el itinerario antes que localidad1 devuelve "ERROR"
(define (subconjunto localidad1 localidad2)
  (if (equal? (buscar_detalle_localidad localidad2) "ERROR") ;Verifica que localidad2 este en el Itinerario
    "ERROR"
    (letrec ([buscar-subconjunto (lambda (lst)
                                (cond
                                  [(null? lst) "ERROR"]
                                  [(equal? (car (car lst)) localidad2) "ERROR"]
                                  [(equal? (car (car lst)) localidad1) lst]
                                  [else (buscar-subconjunto (cdr lst))]))])
      (buscar-subconjunto itinerario))))

;6)Función que recibe dos localidades y devuelve el precio del viaje entre ellas
(define (precio_viaje localidad1 localidad2)
  (if (equal? (subconjunto localidad1 localidad2) "ERROR") ;Verifica si localidad1 y localidad2 son válidas
      "ERROR"
      (letrec ([precio (lambda (lst)
                         (cond
                           [(null? lst) "ERROR"]
                           [(equal? (car (car lst)) localidad2) 0]
                           [else (+ (car (cdr (car lst))) (precio (cdr lst)))]))])
        (precio (subconjunto localidad1 localidad2)))))

;7)Función que recibe una localidad y una hora de consulta y devuelve
;   una lista con los horarios de salida disponibles para esa localidad
(define (verificar_horario hora_consulta localidad)
  (define horas_disponibles (horarios localidad))
  (letrec ([resultado (lambda (lst1)
                         (cond
                           [(null? lst1) '()]
                           [(hora_valida hora_consulta (car lst1)) lst1]
                           [else (resultado (cdr lst1))]))])
        (resultado horas_disponibles)))

;8)Función que recibe una lista de consulta con  localidad de salida, localidad de llegada y hora de consulta
;   y devuelve una lista con la localidad de salida, localidad de llegada, precio del viaje y horarios de salida disponibles
;   si la localidad de salida no se encuentra en el itinerario devuelve "ERROR"
;   si la localidad de llegada no se encuentra en el itinerario devuelve "ERROR"
;   si la localidad de salida no se encuentra antes que la localidad de llegada devuelve "ERROR"
;   si la localidad de salida y la localidad de llegada son iguales devuelve "ERROR"
;   si no hay horarios de salida disponibles devuelve "NO HAY HORARIOS DE SALIDA DISPONIBLES"
(define (ArgentinaTur lista_consulta)
  (define resultado (precio_viaje (car lista_consulta) (car(cdr lista_consulta))))
  (if (equal? resultado  "ERROR")
    "ERROR"
    (if (equal? (verificar_horario (car(cdr(cdr lista_consulta))) (car lista_consulta)) '() )
      (list (list (car lista_consulta) (car(cdr lista_consulta))) 0 "NO HAY HORARIOS DE SALIDA DISPONIBLES")
      (list (list (car lista_consulta) (car(cdr lista_consulta))) resultado (verificar_horario (car(cdr(cdr lista_consulta))) (car lista_consulta))))))

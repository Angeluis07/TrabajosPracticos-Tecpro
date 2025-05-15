;#lang racket

;1) Listar cada una de las localidades, su costo y horarios de salida
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



(define (buscar_detalle_localidad localidad)
  (letrec ([buscar-localidad (lambda (lst)
                               (cond
                                 [(null? lst) "Error"]
                                 [(equal? (car (car lst)) localidad) (car lst)]
                                 [else (buscar-localidad (cdr lst))]))])
    (buscar-localidad itinerario)))


;2) Obtener la lista de horarios de una localidad
(define (horarios localidad)
 (car(cdr(cdr (buscar_detalle_localidad localidad)))))

(define (hora_valida hora_consulta hora_salida)
  (cond
    [(< (car hora_consulta) (car hora_salida)) #t]
    [(and (= (car hora_consulta) (car hora_salida)) (<= (cadr hora_consulta) (cadr hora_salida))) #t]
    [else #f]))


;3) Funcion que recibe dos localidades y devuelve el un subconjuto con localidad 1
(define (subconjunto localidad1 localidad2)
  (letrec ([buscar-subconjunto (lambda (lst)
                               (cond
                                 [(null? lst) "ERROR"]
                                 [(equal? (car (car lst)) localidad2) "ERROR"]
                                 [(equal? (car (car lst)) localidad1) lst]
                                 [else (buscar-subconjunto (cdr lst))]))])
    (buscar-subconjunto itinerario)))

(define (precio_viaje localidad1 localidad2)
  (if (equal? (subconjunto localidad1 localidad2) "ERROR")
      "ERROR"
      (letrec ([precio (lambda (lst)
                         (cond
                           [(null? lst) "ERROR"]
                           [(equal? (car (car lst)) localidad2) 0]
                           [else (+ (car (cdr (car lst))) (precio (cdr lst)))]))])
        (precio (subconjunto localidad1 localidad2)))))

(define (verificar_horario hora_consulta localidad)
  (define horas_disponibles (horarios localidad))
  (letrec ([resultado (lambda (lst1)
                         (cond
                           [(hora_valida hora_consulta car(lst1)) lst1]
                           [(null? lst1) '()]
                           [else (resultado (cdr lst1))]))])
        (resultado (horas_disponibles))))


(define (ArgentinaTur lista_consulta)
  (define resultado (precio_viaje car(lista_consulta) car(cdr(lista_consulta))))
  (if (equal? resultado  "ERROR")
    "ERROR"
    (if (equal? (verificar_horario (car(cdr(cdr lista_consulta)))) '() )
      (list (list car(lista_consulta) car(cdr(lista_consulta))) 0 "NO HAY HORARIOS DE SALIDA DISPONIBLES")
      (list (list car(lista_consulta) car(cdr(lista_consulta))) resultado (verificar_horario (car(cdr(cdr lista_consulta))) car(lista_consulta))))))





;Wrapper ArgentinaTur

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



(define localidades '("Buenos Aires" "Córdoba" "Rosario" "Mendoza" "Salta"))


;2) Obtener la lista de horarios de una localidad
(define (horarios localidad)
 (letrec ([buscar-horarios (lambda (lst)
                            (cond
                              ; El condicional cond permite que se evaluen estas 3 condiciones 
                              [(null? lst) "Error"]
                              [(equal? (car (car lst)) localidad) (caddr (car lst))]
                              [else (buscar-horarios (cdr lst))]))])
      (buscar-horarios itinerario)))
  

;3) Obtener precio de una localidad
(define (precio localidad)
 (letrec ([buscar-precio (lambda (lst)
                            (cond
                              ; El condicional cond permite que se evaluen estas 3 condiciones 
                              [(null? lst) "Error"]
                              [(equal? (car (car lst)) localidad) (cadr (car lst))]
                              [else (buscar-precio (cdr lst))]))])
      (buscar-precio itinerario)))


;3) Funcion que recibe dos localidades y devuelve el un subconjuto con localidad 1


;Wrapper ArgentinaTur

% Integrantes: Albarenque Junior, Godoy Matias, Lencina Federico, Palacios Angel

% Colocar en la consola el siguiente comando para que muestre completas las listas demasiados extensas
% set_prolog_flag(answer_write_options,[max_depth(0)]).  
% configura la profundidad máxima de impresión de términos (como listas o estructuras anidadas) a ilimitada.

% Base de conocimiento
costoTramo(['Cordoba Capital', 'Carlos Paz'], 1500).
costoTramo(['Carlos Paz', 'Bialet Masse'], 1500).
costoTramo(['Bialet Masse', 'Valle Hermoso'], 1000).
costoTramo(['Valle Hermoso', 'La Falda'], 1200).
costoTramo(['La Falda', 'Huerta Grande'], 1000).
costoTramo(['Huerta Grande', 'La Cumbre'], 1200).
costoTramo(['La Cumbre', 'Capilla Del Monte'], 1600).

caminoDe(jorge, ['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda']).
caminoDe(adriana, ['Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre']).
caminoDe(gabriela, ['Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).
caminoDe(roberto, ['Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande']).
caminoDe(jose, ['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).

% Regla para obtener los tramos de un camino
% Un tramo es un par (origen, destino)
obtener_tramos([_],[]) :- !.
obtener_tramos([X,Y|Cola], [[X,Y]|Resultado]):-
    obtener_tramos([Y|Cola], Resultado).

% Regla para obtener los tramos de cada persona
obtener_tramos_personas([], []):- !.
obtener_tramos_personas([Nombre|Resto], [[Nombre, Tramos]|Resultado]) :-
    caminoDe(Nombre,List),
    obtener_tramos(List, Tramos),
    obtener_tramos_personas(Resto, Resultado).

% Regla para contar los tramos de cada persona
% Arma pares (tramo, cantidad) de tramos recorridos por cada persona
contar_tramo(Tramo, [], [[Tramo, 1]]) :- !.
contar_tramo(Tramo, [[T, Cantidad]|Resto], [[T, Cantidad]|Final]) :-
    T \= Tramo,
    contar_tramo(Tramo, Resto, Final).
contar_tramo(Tramo, [[T, Cantidad]|Resto], [[T, Cantidad_2]|Resto]) :-
    T == Tramo,
    Cantidad_2 is Cantidad + 1.

% Regla que suma los tramos que recorre una persona
sumar_tramos_persona([], Acumulador, Acumulador) :- !.
sumar_tramos_persona([Tramo|Resto], Acumulador, Resultado) :-
    contar_tramo(Tramo, Acumulador, Nuevo_acumulador),
    sumar_tramos_persona(Resto, Nuevo_acumulador, Resultado).

% Regla que cuenta los tramos totales recorridos por todas las personas
contar_tramos_totales([], Acc, Acc) :- !.
contar_tramos_totales([[_,Tramos]|Resto], Acc, ResultadoFinal) :-
    sumar_tramos_persona(Tramos, Acc, NuevoAcc),
    contar_tramos_totales(Resto, NuevoAcc, ResultadoFinal).

% Regla que verifica si un tramo pertenece a la lista de tramos de una persona
pertenece_tramo([],_):- fail,!.
pertenece_tramo([Tramo|_], Tramo).
pertenece_tramo([_|Tramos_persona],Tramo) :-
    pertenece_tramo(Tramos_persona,Tramo).

% Regla que suma el costo parcial de los tramos recorridos por una persona
% Recibe una lista de tramos con su cantidad y una persona
sumar_costo_parcial([],_,0):-!.
sumar_costo_parcial([[X,N]|ListaTramos],Persona,Resultado):-
    caminoDe(Persona,Camino_persona),
    obtener_tramos(Camino_persona,Tramos_persona),
    pertenece_tramo(Tramos_persona,X),
    costoTramo(X,Total),
    sumar_costo_parcial(ListaTramos,Persona,Resultado2),
    Resultado is Resultado2 + Total/N,
    !.
sumar_costo_parcial([[_,_]|ListaTramos],Persona,Resultado):-
    sumar_costo_parcial(ListaTramos,Persona,Resultado).

% Regla que estructura la lista final con el nombre de la persona, su camino y el costo total
% Recibe una lista de personas y una lista de tramos con su cantidad
estructurar([],_,[]):-!.
estructurar([X|Personas],Tramos_cantidad,[[X,Camino_X,Total_X]|Resultado]):-
    estructurar(Personas,Tramos_cantidad,Resultado),
    caminoDe(X,Camino_X),
    sumar_costo_parcial(Tramos_cantidad,X,Total_X).

% Regla principal que recibe una lista de personas y devuelve una lista final con el nombre, camino y costo total
repartir_costos(Personas,Lista_final):-
    obtener_tramos_personas(Personas,Tramos_personas),
    contar_tramos_totales(Tramos_personas, [], Resultado),
    estructurar(Personas,Resultado,Lista_final),
    !.
/*
26 ?- repartir_costos([jorge], Resultado).
Resultado = [[jorge,[Cordoba Capital,Carlos Paz,Bialet Masse,Valle Hermoso,La Falda],5200]].

27 ?-  repartir_costos([jorge, adriana], Resultado).
Resultado = [[jorge,[Cordoba Capital,Carlos Paz,Bialet Masse,Valle Hermoso,La Falda],4600],[adriana,[Valle Hermoso,La Falda,Huerta Grande,La Cumbre],2800]].

28 ?- repartir_costos([jorge, adriana, gabriela], Resultado).
Resultado = [[jorge,[Cordoba Capital,Carlos Paz,Bialet Masse,Valle Hermoso,La Falda],3150],[adriana,[Valle Hermoso,La Falda,Huerta Grande,La Cumbre],1500],[gabriela,[Carlos Paz,Bialet Masse,Valle Hermoso,La Falda,Huerta Grande,La Cumbre,Capilla Del Monte],4350]].

29 ?- repartir_costos([jorge, adriana, gabriela, roberto, jose], Resultado).
Resultado = [[jorge,[Cordoba Capital,Carlos Paz,Bialet Masse,Valle Hermoso,La Falda],1740],[adriana,[Valle Hermoso,La Falda,Huerta Grande,La Cumbre],890],[gabriela,[Carlos Paz,Bialet Masse,Valle Hermoso,La Falda,Huerta Grande,La Cumbre,Capilla Del Monte],2440],[roberto,[Bialet Masse,Valle Hermoso,La Falda,Huerta Grande],740],[jose,[Cordoba Capital,Carlos Paz,Bialet Masse,Valle Hermoso,La Falda,Huerta Grande,La Cumbre,Capilla Del Monte],3190]].
*/
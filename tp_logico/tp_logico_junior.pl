% Base de conocimiento
localidad('Cordoba Capital').
localidad('Carlos Paz').
localidad('Bialet Masse').
localidad('Valle Hermoso').
localidad('La Falda').
localidad('Huerta Grande').
localidad('La Cumbre').
localidad('Capilla Del Monte').

tramo('Cordoba Capital', 'Carlos Paz').
tramo('Carlos Paz', 'Bialet Masse').
tramo('Bialet Masse', 'Valle Hermoso').
tramo('Valle Hermoso', 'La Falda').
tramo('La Falda', 'Huerta Grande').
tramo('Huerta Grande', 'La Cumbre').
tramo('La Cumbre', 'Capilla Del Monte').

costoTramo(['Cordoba Capital', 'Carlos Paz'], 1500).
costoTramo(['Carlos Paz', 'Bialet Masse'], 1500).
costoTramo(['Bialet Masse', 'Valle Hermoso'], 1000).
costoTramo(['Valle Hermoso', 'La Falda'], 1200).
costoTramo(['La Falda', 'Huerta Grande'], 1000).
costoTramo(['Huerta Grande', 'La Cumbre'], 1200).
costoTramo(['La Cumbre', 'Capilla Del Monte'], 1600).

caminoDe('Jorge', ['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda']).
caminoDe('Adriana', ['Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre']).
caminoDe('Gabriela', ['Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).
caminoDe('Roberto', ['Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande']).
caminoDe('Jose', ['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).

recorridoCompleto(['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).


obtener_tramos([_],[]) :- !.
obtener_tramos([X,Y|Cola], [[X,Y]|Resultado]):-
    obtener_tramos([Y|Cola], Resultado).

obtener_tramos_personas([], []):- !.
obtener_tramos_personas([Nombre|Resto], [[Nombre, Tramos]|Resultado]) :-
    caminoDe(Nombre,List),
    obtener_tramos(List, Tramos),
    obtener_tramos_personas(Resto, Resultado).

contar_tramo(Tramo, [], [[Tramo, 1]]) :- !.
contar_tramo(Tramo, [[T, N]|Resto], [[T, N]|Final]) :-
    T \= Tramo,
    contar_tramo(Tramo, Resto, Final).

contar_tramo(Tramo, [[T, N]|Resto], [[T, M]|Resto]) :-
    T == Tramo,
    M is N + 1.


%revisar estas dos de abajo
sumar_tramos_persona([], Acc, Acc) :- !.
sumar_tramos_persona([X|Xs], Acc, Resultado) :-
    contar_tramo(X, Acc, NuevoAcc),
    sumar_tramos_persona(Xs, NuevoAcc, Resultado).

contar_tramos_totales([], Acc, Acc) :- !.
contar_tramos_totales([[_,Tramos]|Resto], Acc, ResultadoFinal) :-
    sumar_tramos_persona(Tramos, Acc, NuevoAcc),
    contar_tramos_totales(Resto, NuevoAcc, ResultadoFinal).


pertenece_tramo([],_):- fail,!.
pertenece_tramo([Tramo|_], Tramo).
pertenece_tramo([_|Tramos_persona],Tramo) :-
    pertenece_tramo(Tramos_persona,Tramo).

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

estructurar([],_,[]):-!.
estructurar([X|Personas],Tramos_cantidad,[[X,Camino_X,Total_X]|Resultado]):-
    estructurar(Personas,Tramos_cantidad,Resultado),
    caminoDe(X,Camino_X),
    sumar_costo_parcial(Tramos_cantidad,X,Total_X).
repartir_costos(Personas,Lista_final):-
    obtener_tramos_personas(Personas,Tramos_personas),
    contar_tramos_totales(Tramos_personas, [], Resultado),
    estructurar(Personas,Resultado,Lista_final),
    !.


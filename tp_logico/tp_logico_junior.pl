% Base de conocimiento
localidad('a').
localidad('b').
localidad('c').
localidad('d').
localidad('e').
localidad('f').
localidad('g').
localidad('h').

tramo('a', 'b').
tramo('b', 'c').
tramo('c', 'd').
tramo('d', 'e').
tramo('e', 'f').
tramo('f', 'g').
tramo('g', 'h').

costoTramo(['a', 'b'], 1500).
costoTramo(['b', 'c'], 1500).
costoTramo(['c', 'd'], 1000).
costoTramo(['d', 'e'], 1200).
costoTramo(['e', 'f'], 1000).
costoTramo(['f', 'g'], 1200).
costoTramo(['g', 'h'], 1600).

caminoDe('Jorge', ['a', 'b', 'c', 'd', 'e']).
caminoDe('Adriana', ['d', 'e', 'f', 'g']).
caminoDe('Gabriela', ['b', 'c', 'd', 'e', 'f', 'g', 'h']).
caminoDe('Roberto', ['c', 'd', 'e', 'f']).
caminoDe('Jose', ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']).

recorridoCompleto(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']).


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
pertenece_tramo([Tramo|Tramos_persona], Tramo).
pertenece_tramo([X|Tramos_persona],Tramo) :-
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

sumar_costo_parcial([[X,N]|ListaTramos],Persona,Resultado):-
    sumar_costo_parcial(ListaTramos,Persona,Resultado).

estructurar([],_,[]).
estructurar([X|Personas],Tramos_cantidad,[[X,Camino_X,Total_X]|Resultado]):-
    estructurar(Personas,Tramos_cantidad,Resultado),
    caminoDe(X,Camino_X),
    sumar_costo_parcial(Tramos_cantidad,X,Total_X).
ds(Personas,Resultado,Lista_final):-
    obtener_tramos_personas(Personas,Tramos_personas),
    contar_tramos_totales(Tramos_personas, [], Resultado),
    estructurar(Personas,Resultado,Lista_final).


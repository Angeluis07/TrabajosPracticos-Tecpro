% Base de conocimiento
localidad('a').
localidad('b').
localidad('c').
localidad('d').
localidad('e').
localidad('f').
localidad('g').
localidad('h').

costoLocalidad('a', 1500).
costoLocalidad('b', 1500).
costoLocalidad('c', 1000).
costoLocalidad('d', 1200).
costoLocalidad('e', 1000).
costoLocalidad('f', 1200).
costoLocalidad('g', 1600).
costoLocalidad('h', 0).

tramo('a', 'b').
tramo('b', 'c').
tramo('c', 'd').
tramo('d', 'e').
tramo('e', 'f').
tramo('f', 'g').
tramo('g', 'h').

costoTramo('a', 'b', 1500).
costoTramo('b', 'c', 1500).
costoTramo('c', 'd', 1000).
costoTramo('d', 'e', 1200).
costoTramo('e', 'f', 1000).
costoTramo('f', 'g', 1200).
costoTramo('g', 'h', 1600).

persona('Jorge').
persona('Adriana').
persona('Gabriela').
persona('Roberto').
persona('Jose').

caminoDe('Jorge', ['a', 'b', 'c', 'd', 'e']).
caminoDe('Adriana', ['d', 'e', 'f', 'g']).
caminoDe('Gabriela', ['b', 'c', 'd', 'e', 'f', 'g', 'h']).
caminoDe('Roberto', ['c', 'd', 'e', 'f']).
caminoDe('Jose', ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']).

recorridoCompleto(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']).


obtener_tramos([_],[]) :- !.
obtener_tramos([X,Y|Cola], [[X,Y]|Resultado]):-
    obtener_tramos([Y|Cola], Resultado).

obtener_tramos_personas([], []).
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

estructurar_aux([],[]):-!.
estructurar_aux([X|List],Resultado_final) :-
    estructurar_aux(List,Resultado),
    contar_tramo(X,Resultado,Resultado_final).



%revisar estas dos de abajo
estructurar_aux([], Acc, Acc).
estructurar_aux([X|Xs], Acc, Resultado) :-
    contar_tramo(X, Acc, NuevoAcc),
    estructurar_aux(Xs, NuevoAcc, Resultado).

estructurar([], Acc, Acc).
estructurar([[_,Tramos]|Resto], Acc, ResultadoFinal) :-
    estructurar_aux(Tramos, Acc, NuevoAcc),
    estructurar(Resto, NuevoAcc, ResultadoFinal).

ds(Personas,Resultado):-
    obtener_tramos_personas(Personas,Tramos_personas),
    estructurar(Tramos_personas, [], Resultado).
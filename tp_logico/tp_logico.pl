%SI NO PROBAR CON QUE LOS VIAJES DE CADA PERSONA SEAN TRAMOS Y NO UNA LISTA COMPLETA
%ASI PUEDO COMPARAR POR TRAMOS

% Base de conocimiento
idLocalidad('Cordoba Capital', 1).
idLocalidad('Carlos Paz', 2).
idLocalidad('Bialet Masse', 3).
idLocalidad('Valle Hermoso', 4).
idLocalidad('La Falda', 5).
idLocalidad('Huerta Grande', 6).
idLocalidad('La Cumbre', 7).
idLocalidad('Capilla Del Monte', 8).

tramo(['Cordoba Capital', 'Carlos Paz']).
tramo(['Carlos Paz', 'Bialet Masse']).
tramo(['Bialet Masse', 'Valle Hermoso']).
tramo(['Valle Hermoso', 'La Falda']).
tramo(['La Falda', 'Huerta Grande']).
tramo(['Huerta Grande', 'La Cumbre']).
tramo(['La Cumbre', 'Capilla Del Monte']).

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

tramosDe('Jorge', [['Cordoba Capital', 'Carlos Paz'], ['Carlos Paz', 'Bialet Masse'],
         ['Bialet Masse', 'Valle Hermoso'], ['Valle Hermoso', 'La Falda']]).
tramosDe('Adriana', [['Valle Hermoso', 'La Falda'], ['La Falda', 'Huerta Grande'], ['Huerta Grande', 'La Cumbre']]).
tramosDe('Gabriela', [['Carlos Paz', 'Bialet Masse'], ['Bialet Masse', 'Valle Hermoso'], ['Valle Hermoso', 'La Falda'],
         ['La Falda', 'Huerta Grande'], ['Huerta Grande', 'La Cumbre'], ['La Cumbre', 'Capilla Del Monte']]).
tramosDe('Roberto', [['Bialet Masse', 'Valle Hermoso'], ['Valle Hermoso', 'La Falda'], ['La Falda', 'Huerta Grande']]).
tramosDe('Jose',[['Cordoba Capital', 'Carlos Paz'], ['Carlos Paz', 'Bialet Masse'], ['Bialet Masse', 'Valle Hermoso'],
         ['Valle Hermoso', 'La Falda'], ['La Falda', 'Huerta Grande'], ['Huerta Grande', 'La Cumbre'], ['La Cumbre', 'Capilla Del Monte']]).
% Reglas
/*
El mismo recibe una lista de personas que van a repartir su costo, y una lista en que se coloca
el resultado. El resultado debe ser una lista de listas, donde cada sublista contien:
 a. El nombre de la persona,
 b. La lista de tramos que recorrió,
 c. El total que debe pagar.

Los pasos para obtener el resultado son los siguientes:
    1. Por cada persona, obtenemos el camino (lista de localidades). viaje(X,Y)
    2. A partir del camino, obtenemos los tramos.
    3. Por cada tramo, calculamos cuántas personas lo usan.
    4. Dividimos el costo del tramo por esa cantidad.
    5. Sumamos los costos parciales.
    6. Construimos la salida con [Persona, Camino, CostoTotal].
Pueden usar esta lista para construir predicados auxiliares.
*/

% Regla para insertar_ordenado(X, lista, lista_ordenada)
insertar_ordenado(X, [], [X]).
insertar_ordenado(X, [Y|Cola], [X,Y|Cola]) :-
    X =< Y.
insertar_ordenado(X, [Y|Cola], [Y|Listaord]) :-
    X > Y,
    insertar_ordenado(X, Cola, Listaord).

% Regla que ordena una lista
ordenar([],[]).
ordenar([X|Cola], ListaOrdenada) :-
    ordenar(Cola, ListaParcial),
    insertar_ordenado(X,ListaParcial,ListaOrdenada).

% Regla para obtener una lista con las id de localidades
localidades_id([],[]).
localidades_id([Localidad|Cola],[Id|ColaResultado]) :-
    idLocalidad(Localidad,Id),
    localidades_id(Cola,ColaResultado).

% Regla para obtener una lista con las localidades a partir de una id
id_localidades([],[]).
id_localidades([Id|Cola],[Localidad|ColaResultado]) :-
    idLocalidad(Localidad,Id),
    id_localidades(Cola,ColaResultado).

% Regla para eliminar ocurrencias de un elemento en una Lista
eliminar_elemento(_,[],[]).
eliminar_elemento(E,[E|R],Resultado) :- eliminar_elemento(E,R,Resultado).
eliminar_elemento(E,[X|R],[X|Resultado]) :- E \= X, eliminar_elemento(E,R,Resultado).

% Regla para elimnar elementos duplicados de una lista
eliminar_dup([],[]).
eliminar_dup([X|R],[X|Resultado]) :-
  eliminar_elemento(X,R,Limpia), eliminar_dup(Limpia, Resultado).

% Regla para concatenar dos listas
concatenar([],L,L).
concatenar([X|Cola],L,[X|Cola2]) :-
    concatenar(Cola,L,Cola2).

% Regla para concatenar todos los caminos de las personas
concatenarCaminos([],[]).
concatenarCaminos([X|Cola], ListaCaminos) :-
    caminoDe(X,CamX),
    concatenarCaminos(Cola,CaminoParcial),
    concatenar(CamX,CaminoParcial,ListaCaminos).

% Regla para saber el camino/recorrido total del colectivo
camino(ListaPersonas, Camino) :-
    concatenarCaminos(ListaPersonas, ListaCaminos),
    eliminar_dup(ListaCaminos,CaminosSinDup),
    localidades_id(CaminosSinDup,CaminosId),
    ordenar(CaminosId,IdOrdenados),
    id_localidades(IdOrdenados,Camino).

% Regla para obtener una lista de tramos a partir del camino
tramos([_],[]).
tramos([X,Y|Cola],[[X,Y]|Cola2]) :-
    tramos([Y|Cola],Cola2).








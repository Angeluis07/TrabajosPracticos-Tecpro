
% PASO 4 DIVIDIR EL COSTO DEL TRAÑO POR LA CANTIDAD DE PERSONAS Q LO USAN.

% Predicado que calcula el costo individual de un tramo para una persona
% [X,Y], tramo entre X e Y
% ListaTramosCant, lista de tramos con la cantidad de personas que lo usan (parte de JR)
% Costo, resultado del costo individual para ese tramo
costo_individual_tramo([X,Y], ListaTramosCant, Costo) :-
    costoTramo([X,Y], CostoTotal), % Obtengo el costo total del tramo entre X e Y
    buscar_cantidad([[X,Y], Cantidad], ListaTramosCant, Cantidad), % Busca cuántas personas usan ese tramo
    Costo is CostoTotal // Cantidad. % Divide el costo total por la cantidad de personas

% Predicado auxiliar para buscar la cantidad de personas que usan un tramo
% Caso base, si no se encuentra el tramo, por defecto retorna 1 (no debería pasar nunca)
buscar_cantidad(_, [], _) :- fail.

% Si el tramo coincide con el de la lista, retorna la cantidad encontrada
buscar_cantidad([Tramo, Cant], [[Tramo, Cant]|_], Cant).

% Caso recursivo: sigue buscando en el resto de la lista
buscar_cantidad([Tramo, _], [_|Resto], Cant) :-
    buscar_cantidad([Tramo, _], Resto, Cant).

% Consulta:
% costo_individual_tramo(['Carlos Paz', 'Bialet Masse'], [[['Carlos Paz','Bialet Masse'],2],[['Bialet Masse','Valle Hermoso'],4]], Costo).
% resultado esperado -> Costo 750.




% PARTE 5. Sumar los costos parciales, dado a una persona
% Supongo q la funcion que muestre la salida sera un wrapper, entonces
% Cuando tengamos el listado de los tramos y el precio. entonces

% Caso base, los tramos a sumar esta vacio
% [Tramo|Resto]. Lista de tramos, donde:
% Tramo, la cabeza de la lista
% Resto, cola de la lista
% ListaTramoCant, es la lista que contiene al par [[Salida, Llegada],Cantidad]
% Costo, resultado del costo individual para ese tramo
sumar_costos_tramos([],_,0).
sumar_costos_tramos([Tramo|Resto], ListaTramosCant, Suma) :-
    costo_individual_tramo(Tramo, ListaTramosCant, Costo), % Obtengo el costo del tramo actual.
    sumar_costos_tramos(Resto, ListaTramosCant, SumaResto), % Obtengo la suma de los elementos siguientes.
    Suma is Costo + SumaResto.
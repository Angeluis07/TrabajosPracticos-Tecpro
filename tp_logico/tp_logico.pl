% Base de conocimiento
localidad('Cordoba Capital').
localidad('Carlos Paz').
localidad('Bialet Masse').
localidad('Valle Hermoso').
localidad('La Falda').
localidad('Huerta Grande').
localidad('La Cumbre').
localidad('Capilla Del Monte').

costoLocalidad('Cordoba Capital', 1500).
costoLocalidad('Carlos Paz', 1500).
costoLocalidad('Bialet Masse', 1000).
costoLocalidad('Valle Hermoso', 1200).
costoLocalidad('La Falda', 1000).
costoLocalidad('Huerta Grande', 1200).
costoLocalidad('La Cumbre', 1600).
costoLocalidad('Capilla Del Monte', 0).

tramo('Cordoba Capital', 'Carlos Paz').
tramo('Carlos Paz', 'Bialet Masse').
tramo('Bialet Masse', 'Valle Hermoso').
tramo('Valle Hermoso', 'La Falda').
tramo('La Falda', 'Huerta Grande').
tramo('Huerta Grande', 'La Cumbre').
tramo('La Cumbre', 'Capilla Del Monte').

costoTramo('Cordoba Capital', 'Carlos Paz', 1500).
costoTramo('Carlos Paz', 'Bialet Masse', 1500).
costoTramo('Bialet Masse', 'Valle Hermoso', 1000).
costoTramo('Valle Hermoso', 'La Falda', 1200).
costoTramo('La Falda', 'Huerta Grande', 1000).
costoTramo('Huerta Grande', 'La Cumbre', 1200).
costoTramo('La Cumbre', 'Capilla Del Monte', 1600).

persona('Jorge').
persona('Adriana').
persona('Gabriela').
persona('Roberto').
persona('Jose').

caminoDe('Jorge', ['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda']).
caminoDe('Adriana', ['Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre']).
caminoDe('Gabriela', ['Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).
caminoDe('Roberto', ['Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande']).
caminoDe('Jose', ['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).

recorridoCompleto(['Cordoba Capital', 'Carlos Paz', 'Bialet Masse', 'Valle Hermoso', 'La Falda', 'Huerta Grande', 'La Cumbre', 'Capilla Del Monte']).
% Reglas


% La regla camino recibe una lista de personas y devuelve el camino que realice el colectivo
camino([X|Cola], ListaCamino) :-


repartir_costos([X|ListaPersona], Resultado) :-


/*
repartir_costos/2



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

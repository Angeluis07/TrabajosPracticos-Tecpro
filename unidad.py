from asiento import Asiento
from typing import List
class Unidad:
    def __init__(self, patente, asientos : List['Asiento'] = None):
        self.__patente = patente
        self.__asientos = asientos if asientos else []

    @property
    def patente(self):
        return self.__patente

    @patente.setter
    def patente(self, value):
        self.__patente = value

    @property
    def asientos(self):
        return self.__asientos

    @asientos.setter
    def asientos(self, value):
        self.__asientos.append(value)

    #pensar implementacion, pq se pide mostrar asientos disponibles y tambien el listado completo,
    #yo creo que de esta forma es mejor, que tener dos metodos distintos.
    #Revisar si cumple con tell dont ask
    def mostrar_asientos_disponibles(self): #Muestro los asientos en forma de lista
        print("Listado de Asientos")
        print("  -Disponibles")
        for asiento in self.__asientos:
            print(f"    {asiento.mostrar_si_disponible()}")

    def mostrar_asientos_ocupados(self):
        print("Listado de Asientos")
        print("  -Ocupados")
        for asiento in self.__asientos:
            print(f"    {asiento.mostrar_si_ocupado()}")


    def reservar_asiento(self, asiento: 'Asiento'):
        pass

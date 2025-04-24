from asiento import Asiento
from typing import List 
class Unidad: 
    def __init__(self, patente, asientos : List['Asiento']):
        self.patente = patente
        self.asientos = asientos if asientos else []

    @property
    def patente(self):
        return self._patente

    @patente.setter
    def patente(self, value):
        self._patente = value

    @property
    def asientos(self):
        return self._asientos

    @asientos.setter
    def asientos(self, value):
        self._asientos = value

    #pensar implementacion, pq se pide mostrar asientos disponibles y tambien el listado completo,
    #yo creo que de esta forma es mejor, que tener dos metodos distintos.
    def mostrar_asientos(self, x: bool): #Muestro los asientos en forma de lista
        print("Listado de Asientos")
        print("  -Disponibles")
        for asien in self.asientos:
            if asien.ocupado:
                print(f"    {asien.numero}")
        if not x:        
            print("  -Ocupados")        
            for asien in self.asientos:
                if not asien.ocupado:
                    print(f"    {asien.numero}")


    def reservar_asiento(self, asiento: 'Asiento'):
        pass
        
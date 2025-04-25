from typing import List
from asiento import Asiento

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


    def reservar_asiento(self, asiento: 'Asiento'):
        pass

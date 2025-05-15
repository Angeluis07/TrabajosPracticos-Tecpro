from typing import List
from asiento import Asiento

class Unidad:
    def __init__(self, patente, cant_asientos: int):
        self.__patente = patente
        self.__asientos: List[Asiento] = []
        for i in range(cant_asientos):
            self.__asientos.append(Asiento(i + 1))

    @property
    def patente(self):
        return self.__patente

    @patente.setter
    def patente(self, value):
        self.__patente = value

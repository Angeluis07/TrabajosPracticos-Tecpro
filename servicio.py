from datetime import datetime
from unidad import Unidad
class Servicio:
    def __init__(self, unidad: 'Unidad', fecha_partida: datetime, fecha_llegada: datetime, calidad: str, precio: float):
        self.__unidad = unidad
        self.__fecha_partida = fecha_partida
        self.__fecha_llegada = fecha_llegada
        self.__calidad = calidad
        self.__precio = precio

    @property
    def fecha_partida(self):
        return self.__fecha_partida

    @property
    def fecha_llegada(self):
        return self.__fecha_llegada

    @property
    def unidad(self):
        return self.__unidad

    @property
    def calidad(self):
        return self.__calidad

    @property
    def precio(self):
        return self.__precio

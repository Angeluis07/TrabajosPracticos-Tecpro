import datetime
class Servicio:
    def __init__(self, unidad: Unidad, fecha_partida: datetime, fecha_llegada: datetime, calidad: str, precio: float):
        self.__unidad = unidad
        self.__fecha_partida = fecha_partida
        self.__fecha_llegada = fecha_llegada #Controlar si
        self.__calidad = calidad
        self.__precio = precio
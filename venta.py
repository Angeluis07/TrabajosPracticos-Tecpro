from datetime import datetime
from pasajero import Pasajero
from servicio import Servicio
from asiento import Asiento

class Venta:
    def __init__(self, fecha_hora: datetime, pasajero: 'Pasajero', servicio: 'Servicio', asiento: 'Asiento'):
        if asiento.numero() not in servicio.asientos_disponibles():
            raise ValueError("El asiento no está disponible, es posible que alguien lo haya reservado antes, " \
            "por favor vuelva a ver la lista de asientos disponibles")
        self.__fecha_hora = fecha_hora
        self.__pasajero = pasajero
        self.__servicio = servicio
        self.__asiento = asiento

    @property
    def fecha_hora(self):
        return self.__fecha_hora
    @property
    def pasajero(self):
        return self.__pasajero
    @property
    def servicio(self):
        return self.__servicio
    @property
    def asiento(self):
        return self.__asiento

    def nro_asiento(self):
        return self.__asiento.numero()

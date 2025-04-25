from datetime import datetime,timedelta
from pasajero import Pasajero
from servicio import Servicio
from asiento import Asiento

class Reserva:
    def __init__(self, fecha_hora: datetime, pasajero: 'Pasajero', servicio: 'Servicio', asiento: 'Asiento'):
        self.__fecha_hora =  fecha_hora
        self.__pasajero = pasajero
        self.__servicio = servicio
        self.__asiento = asiento

    def reserva_caducada(self) -> bool:
        return datetime.now() >= (self.__servicio.fecha_partida()-timedelta(minutes=30))

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

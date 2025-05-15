from datetime import datetime,timedelta
from pasajero import Pasajero
from servicio import Servicio
from asiento import Asiento

class Reserva:
    def __init__(self, fecha_hora: datetime, pasajero: 'Pasajero', servicio: 'Servicio', asiento: 'Asiento'):
        if asiento.numero() not in servicio.asientos_disponibles():
            raise ValueError("El asiento no está disponible, por favor vuelva a ver la lista de asientos disponibles")
        if fecha_hora >= servicio.fecha_partida() - timedelta(minutes=30):
            raise ValueError("La reserva debe hacerse con al menos 30 minutos de antelación")
        self.__fecha_hora =  fecha_hora
        self.__pasajero = pasajero
        self.__servicio = servicio
        self.__asiento = asiento
        print(f"Reserva realizada a las {self.fecha_hora}: Pasajero {self.__pasajero.nombre()}, asiento {self.__asiento.numero()}, "
              f"servicio del {self.__servicio.fecha_partida()}")

    def caducada(self) -> bool:
        return datetime.now() >= (self.__servicio.fecha_partida()-timedelta(minutes=30))

    def nro_asiento(self) -> int:
        return self.__asiento.numero()

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

from datetime import datetime
from pasajero import Pasajero
from servicio import Servicio
from asiento import Asiento
from medios_pagos import MedioPago

class Venta:
    def __init__(self, fecha_hora: datetime, pasajero: 'Pasajero', servicio: 'Servicio', asiento: 'Asiento', medio_pago: 'MedioPago'):
        if asiento.numero() not in servicio.asientos_disponibles() or medio_pago.procesar_pago():
            raise ValueError("El asiento no está disponible, es posible que alguien lo haya reservado antes, " \
            "por favor vuelva a ver la lista de asientos disponibles")

        self.__fecha_hora = fecha_hora
        self.__pasajero = pasajero
        self.__servicio = servicio
        self.__asiento = asiento
        self.__medio_pago = medio_pago

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

    @property
    def medio_pago(self):
        return self.__medio_pago

    def nro_asiento(self):
        return self.__asiento.numero()

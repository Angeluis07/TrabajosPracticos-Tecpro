from datetime import datetime, timedelta
from typing import List
from unidad import Unidad
from calidad_servicio import CalidadServicio
from venta import Venta
from reserva import Reserva
from itinerario import Itinerario


class Servicio:
    def __init__(self, unidad: 'Unidad', fecha_partida: datetime, fecha_llegada: datetime, calidad: CalidadServicio, precio: float, itinerario: 'Itinerario'):
        self.__unidad = unidad
        self.__fecha_partida = fecha_partida
        self.__fecha_llegada = fecha_llegada
        self.__calidad = calidad
        self.__precio = precio
        self.__itinerario = itinerario
        self.__ventas: List[Venta] = []
        self.__reservas: List[Reserva] = []

    @property
    def fecha_partida(self):
        return self.__fecha_partida

    @property
    def ventas(self):
        return self.__ventas

    @property
    def reservas(self):
        return self.__reservas

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

    def asientos_ocupados(self) -> List[int]:
        asientos_ocupados: List[int] = []
        for venta in self.__ventas:
            asientos_ocupados.append(venta.nro_asiento())
        if datetime.now() >= self.__fecha_partida - timedelta(minutes=30):
            for reserva in self.__reservas:
                asientos_ocupados.append(reserva.nro_asiento())
        return asientos_ocupados.sort()

    def asientos_disponibles(self) -> List[int]:
        L1: List[int] = self.__unidad.asientos()
        L2: List[int] = self.asientos_ocupados()
        asientos_disponibles: List[int] = []
        for asiento in L1:
            if asiento.nro_asiento() not in L2:
                asientos_disponibles.append(asiento.numero())
        return asientos_disponibles.sort()

    def __str__(self) -> str :
        return f"Servicio de la unidad {self.__unidad.patente()}(PATENTE) desde {self.__fecha_partida} hasta {self.__fecha_llegada} con calidad {self.__calidad.nombre()} y precio {self.__precio} \n {self.__itinerario}"

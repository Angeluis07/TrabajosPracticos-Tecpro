from datetime import datetime, timedelta
from typing import List
from unidad import Unidad
from calidad_servicio import CalidadServicio
from venta import Venta
from reserva import Reserva
from itinerario import Itinerario


class Servicio:
    def __init__(self, unidad: 'Unidad', fecha_partida: datetime, fecha_llegada: datetime, calidad: CalidadServicio,
                 precio: float, itinerario: 'Itinerario'):
        self.__unidad = unidad
        self.__fecha_partida = fecha_partida
        self.__fecha_llegada = fecha_llegada
        self.__calidad = calidad
        self.__precio = precio
        self.__itinerario = itinerario
        self.__ventas: List[Venta] = []
        self.__reservas: List[Reserva] = []

    @property
    def unidad(self):
        return self.__unidad

    @unidad.setter
    def unidad(self,unidad_nueva: Unidad):
        self.__unidad = unidad_nueva

    @property
    def fecha_partida(self):
        return self.__fecha_partida

    @property
    def fecha_llegada(self):
        return self.__fecha_llegada

    @property
    def calidad(self):
        return self.__calidad

    @calidad.setter
    def calidad(self, calidad_nueva: CalidadServicio):
        self.__calidad = calidad_nueva

    @property
    def precio(self):
        return self.__precio

    @precio.setter
    def precio(self, precio_nuevo: float):
        self.__precio = precio_nuevo

    @property
    def ventas(self):
        return self.__ventas

    @ventas.setter
    def ventas(self, venta: Venta):
        self.__ventas.append(venta)

    @property
    def reservas(self):
        return self.__reservas

    @reservas.setter
    def reservas(self, reserva: Reserva):
        self.__reservas.append(reserva)

    def asientos_ocupados(self) -> List[int]:
        asientos_ocupados: List[int] = []
        for venta in self.__ventas:
            asientos_ocupados.append(venta.nro_asiento())
        if datetime.now() >= self.__fecha_partida - timedelta(minutes=30):
            for reserva in self.__reservas:
                asientos_ocupados.append(reserva.nro_asiento())
        return asientos_ocupados.sort()

    def asientos_disponibles(self) -> List[int]:
        l1: List[int] = self.__unidad.asientos()
        l2: List[int] = self.asientos_ocupados()
        asientos_disponibles: List[int] = []
        for asiento in l1:
            if asiento.nro_asiento() not in l2:
                asientos_disponibles.append(asiento.numero())
        return asientos_disponibles.sort()

    def disponible(self) -> bool:
        return self.__fecha_partida > datetime.now()

    def __str__(self) -> str:
        return (
            f"Servicio de la unidad {self.__unidad.patente()} (PATENTE)\n"
            f"Desde: {self.__fecha_partida}\n"
            f"Hasta: {self.__fecha_llegada}\n"
            f"Calidad: {self.__calidad.nombre()}\n"
            f"Precio: {self.__precio}\n"
            f"Itinerario:\n{self.__itinerario}"
        )

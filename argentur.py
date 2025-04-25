from typing import List
from datetime import datetime
from servicio import Servicio


class Argentur:
    def __init__(self):
        self.__servicios: List[Servicio] = []

    @property
    def servicios(self)->List['Servicio']:
        return self.__servicios

    @servicios.setter
    def servicios(self, servicio_nuevo: 'Servicio'):
        self.__servicios.append(servicio_nuevo)

    def servicios_disponibles(self):
        print("Bienvenido a Argentur")
        print(" -Servicios Disponibles:")
        for id_servicio, servicio in enumerate(self.servicios, start=1):  #Enumerate devuelve un par índice, servicio
            print(f"   * Servicio [{id_servicio}] - {servicio}" if servicio.disponible() else "")

    def informe_ingresos(self, fecha_desde: datetime, fecha_hasta: datetime):
        print("Informe de ingresos:")
        total = 0
        for servicio in self.servicios:
            if fecha_desde <= servicio.fecha_partida() <= fecha_hasta:
                print(f"Servicio: {servicio} - Cantidad de ventas: {servicio.cantidad_ventas()} - Ingresos: {servicio.total_ventas()}")
                total = total + servicio.total_ventas()
        print(f"Total de ingresos entre {fecha_desde} y {fecha_hasta}: {total}")
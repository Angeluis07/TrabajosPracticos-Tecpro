from typing import List
from servicio import Servicio


class Argentur:
    def __init__(self):
        self.__servicios: List[Servicio] = []

    def agregar_servicio(self, servicio: Servicio):
        self.__servicios.append(servicio)

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

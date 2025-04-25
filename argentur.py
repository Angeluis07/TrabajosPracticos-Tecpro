from typing import List
from servicio import Servicio


class Argentur:
    def __init__(self, servicios: List['Servicio']):
        if servicios is None:
            raise ValueError("La lista de servicios no puede estar vacía.")
        elif:
         self.servicios = servicios
    @property
    def servicios(self)->List['Servicio']:
       return self.servicios

    @servicios.setter
    def servicios(self, servicio_nuevo: 'Servicio'):
       self.servicios.append(servicio_nuevo)

    def servicios_disponibles(self):
       print("Bienvenido a Argentur")
       print(" -Servicios Disponibles:")
       
       """
        for id, servicio in enumerate(self.servicios, start=1):  # enumerate devuelve un par índice, servicio
            print(f"   * Servicio [{id}]")
            print(f"     Itinerario:")
            print(f"       - : {servicio.fecha_partida}")
            print(f"       - Destino: {servicio.fecha_llegada}")
            # falta terminar xd
        """

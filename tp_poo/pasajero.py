from venta import Venta
from reserva import Reserva

class Pasajero:
    def __init__(self, nombre: str, email: str, dni: int):
        self.__nombre = nombre
        self.__email = email #Controlar si es privado los atributos
        self.__dni = dni
        self.__reservas = []
        self.__ventas = []

    def realizar_reserva(self, reserva: 'Reserva'):
        self.__reservas.append(reserva)
        #en el main se deberia armar la reserva y luego agregarla a la lista de reservas del pasajero
        #segun lo que se explica en el archivo de respuestas al TPI en la seccion de patron controlador


    def realizar_venta(self, venta: 'Venta'):
        self.__ventas.append(venta)
        #en el main se deberia armar la venta y luego agregarla a la lista de ventas del pasajero
        #segun lo que se explica en el archivo de respuestas al TPI en la seccion de patron controlador

    @property
    def nombre(self):
        return self.__nombre

    @nombre.setter
    def nombre(self, value):
        self.__nombre = value

    @property
    def email(self):
        return self.__email

    @email.setter
    def email(self, value):
        self.__email = value

    @property
    def dni(self):
        return self.__dni

    @dni.setter
    def dni(self, value):
        self.__dni = value

    @property
    def reservas(self):
        return self.__reservas

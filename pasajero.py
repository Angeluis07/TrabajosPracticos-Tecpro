from venta import Venta
from datetime import datetime
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

    def realizar_venta(self, venta: 'Venta'):
        self.__ventas.append(venta)

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


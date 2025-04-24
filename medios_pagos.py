from abc import ABC
from datetime import date
from abc import abstractmethod


class MedioPago(ABC):
    @abstractmethod
    def procesar_pago(self, monto: float):
        pass

class TarjetaCredito(ABC):
    def __init__(self, numero: str, DNI: int, nombre: str, fecha_vencimiento: date):
        super().__init__()
        self.__numero = numero 
        self.__DNI = DNI
        self.__nombre = nombre
        self.__fecha_nacimiento = fecha_vencimiento
    @property
    def numero(self):
        return self.__numero

    @numero.setter
    def numero(self, value):
        self.__numero = value

    @property
    def DNI(self):
        return self.__DNI

    @DNI.setter
    def DNI(self, value):
        self.__DNI = value

    @property
    def nombre(self):
        return self.__nombre

    @nombre.setter
    def nombre(self, value):
        self.__nombre = value

    @property
    def fecha_vencimiento(self):
        return self.__fecha_nacimiento

    @fecha_vencimiento.setter
    def fecha_vencimiento(self, value):
        self.__fecha_nacimiento = value
    
class MercadoPago(MedioPago):
    def __init__(self, celular: str, email: str):
        super().__init__()
        self.celular = celular
        self.email = email
    @property
    def celular(self):
        return self.__celular

    @celular.setter
    def celular(self, value):
        self.__celular = value

    @property
    def email(self):
        return self.__email

    @email.setter
    def email(self, value):
        self.__email = value

class UALA(MedioPago):
    def __init__(self, email: str, nombre_titular: str):
        super().__init__()
        self.__email = email
        self.__nombre_titular = nombre_titular

    @property
    def email(self):
        return self.__email

    @email.setter
    def email(self, value):
        self.__email = value

    @property
    def nombre_titular(self):
        return self.__nombre_titular

    @nombre_titular.setter
    def nombre_titular(self, value):
        self.__nombre_titular = value

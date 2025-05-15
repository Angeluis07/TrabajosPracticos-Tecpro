from abc import ABC
from datetime import date
from abc import abstractmethod


class MedioPago(ABC):
    @abstractmethod
    def procesar_pago(self, monto: float):
        pass

class TarjetaCredito(ABC):
    def __init__(self, numero: str, dni: int, nombre: str, fecha_vencimiento: date):
        super().__init__()
        self.__numero = numero
        self.__dni = dni    #DNI del titular de la tarjeta
        self.__nombre = nombre
        self.__fecha_nacimiento = fecha_vencimiento

    @property
    def numero(self):
        return self.__numero

    @numero.setter
    def numero(self, value):
        self.__numero = value

    @property
    def dni(self):
        return self.__dni

    @dni.setter
    def dni(self, value):
        if not isinstance(value, int):
            raise ValueError("DNI debe ser un número entero.")
        self.__dni = value

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

    #Simulacion del proceso de pago
    def procesar_pago(self, monto: float)->bool:
        estado = True
        if self.fecha_vencimiento > date.today():
            print(f"Pago de ${monto} procesado con tarjeta {self.numero}.")
        else:
            print(f"Pago de ${monto} no procesado. La tarjeta {self.numero} está vencida.")
            estado = False
        return estado


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

    def procesar_pago(self, monto: float)->bool:
        #Simulacion del proceso de pago
        estado = True
        if self.celular and self.email:
            print(f"Pago de ${monto} procesado con MercadoPago.")
        else:
            print(f"Pago de ${monto} no procesado. Datos de MercadoPago incompletos.")
            estado = False
        return estado

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

    def procesar_pago(self, monto: float)->bool:
        #Simulacion del proceso de pago
        #Tambien que tenga en cuenta el size minimo que debe poder tener el mail y el siz emaximo
        estado = True
        if self.email and self.nombre_titular:
            print(f"Pago de ${monto} procesado con UALA.")
        else:
            print(f"Pago de ${monto} no procesado. Datos de UALA incompletos.")
            estado = False
        return estado
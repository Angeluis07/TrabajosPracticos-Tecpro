class Pasajero:
    def __init__(self, nombre: str, email: str, dni: int):
        self.__nombre = nombre
        self.__email = email #Controlar si es privado los atributos
        self.__dni = dni
class Asiento:
    def __init__(self, numero: int):
        self.__numero = numero

    @property
    def numero(self):
        return self.__numero

    @numero.setter
    def numero(self, value):
        self.__numero = value

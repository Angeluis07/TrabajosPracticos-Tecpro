class Asiento:
    def __init__(self, numero: int, ocupado: bool):
        self.__numero = numero
        self.__ocupado = ocupado
        
    @property
    def numero(self):
        return self.__numero

    @numero.setter
    def numero(self, value):
        self.__numero = value

    @property
    def ocupado(self):
        return self.__ocupado

    @ocupado.setter
    def ocupado(self, value):
        self.__ocupado = value
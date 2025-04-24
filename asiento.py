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

    def mostrar_si_ocupado(self):
        if self.__ocupado:
            print(f"El asiento {self.__numero} está ocupado.")

    def mostrar_si_disponible(self):
        if not self.__ocupado:
            print(f"El asiento {self.__numero} está disponible.")
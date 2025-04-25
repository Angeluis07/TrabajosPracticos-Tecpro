from ciudad import Ciudad

class Itinerario:
    def __init__(self, codigo: str, ciudad_origen: Ciudad, ciudad_destino: Ciudad, paradas_intermedias: list[Ciudad]):
        self.__codigo = codigo
        self.__ciudad_origen = ciudad_origen
        self.__ciudad_destino = ciudad_destino
        self.__paradas_intermedias = paradas_intermedias

    @property
    def codigo(self):
        return self.__codigo

    @codigo.setter
    def codigo(self, value):
        self.__codigo = value

    @property
    def ciudad_origen(self):
        return self.__ciudad_origen

    @property
    def ciudad_destino(self):
        return self.__ciudad_destino

    @property
    def paradas_intermedias(self) -> list[Ciudad]:
        return self.__paradas_intermedias

    def __str__(self) -> str:
        return f"Codigo: {self.__codigo}, Ciudad Origen: {self.__ciudad_origen.nombre}, Ciudad Destino: {self.__ciudad_destino.nombre}, Paradas Intermedias: {[ciudad.nombre for ciudad in self.__paradas_intermedias]}"


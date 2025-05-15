class Ciudad:
    def __init__(self, codigo: str, nombre: str, provincia: str):
        self.__codigo = codigo
        self.__nombre = nombre
        self.__provincia = provincia

    @property
    def codigo(self):
        return self.__codigo

    @codigo.setter
    def codigo(self, value):
        self.__codigo = value

    @property
    def nombre(self):
        return self.__nombre

    @nombre.setter
    def nombre(self, value):
        self.__nombre = value

    @property
    def provincia(self):
        return self.__provincia

    @provincia.setter
    def provincia(self, value):
        self.__provincia = value

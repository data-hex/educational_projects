class Vector:
    def __init__(self, *args):
        a = []
        for i in args:
            if isinstance(i, int):
                a += [i]
        self.values = sorted(a)

    def __str__(self):
        if self.values:
            b = [str(i) for i in self.values]
            return f"Вектор({', '.join(b)})"
        else:
            return 'Пустой вектор'
    def __add__(self, other):
        if isinstance(other, int):
            b = [i + other for i in self.values]
            return Vector(*b)
        elif isinstance(other, Vector):
            if len(self.values) != len(other.values):
                print("Сложение векторов разной длины недопустимо")
            b = [sum(i) for i in zip(self.values, other.values)]
            return Vector(*b)
        else:
            print(f"Вектор нельзя сложить с {other}")

    def __mul__(self, other):
        if isinstance(other, int):
            b = [i * other for i in self.values]
            return Vector(*b)
        elif isinstance(other, Vector):
            if len(self.values) != len(other.values):
                print("Умножение векторов разной длины недопустимо")
            b = [i[0] * i[1] for i in zip(self.values, other.values)]
            return Vector(*b)
        else:
            print(f"Вектор нельзя умножать с {other}")


v1 = Vector(1, 2, 3)
print(v1)  # печатает "Вектор(1, 2, 3)"

v2 = Vector(3, 4, 5)
print(v2)  # печатает "Вектор(3, 4, 5)"


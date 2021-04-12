class Calc(object):

    def add(self, val):
        return 1;

    def sub(self, val):
        return 1;

    def mul(self, val):
        return 1;

    def div(self, val):
        return 1;




methods = [attr for attr in dir(Calc) if callable(getattr(Calc, attr)) and attr.startswith('__') is False]

print(methods)

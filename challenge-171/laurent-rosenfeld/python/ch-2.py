def compose(f1, f2):
    return lambda x: f1(f2(x))
def f(p):
    return p / 2 + 1
def g(p):
    return p * 2

h = compose(f, g)

for i in range(1, 6):
    print (f(g(i)), " ", h(i))

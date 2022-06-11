from sympy import isprime
from itertools import islice


def Padovan():
    p = [1, 1, 1]

    while True:
        p.append(p[-2] + p[-3])
        yield p.pop(0)


def squish(a):
    last = None
    for i in a:
        if i != last:
            yield i
        last = i


def head(n, iterable):
    return list(islice(iterable, n))


print(head(10, squish(filter(isprime, Padovan()))))

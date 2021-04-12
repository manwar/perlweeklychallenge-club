import numpy

def sd (b):
    if b in (2,3,6):
        return -1
    dec = ((b-4)*(b**(b-1)) + 2*(b**(b-2)) + b**(b-3) + b**3)
    return numpy.base_repr(dec, base=b)


for b in range(2,36):
    print(sd(b))

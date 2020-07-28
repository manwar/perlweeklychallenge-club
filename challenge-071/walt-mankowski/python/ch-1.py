from sys import argv
from random import randint

def make_array(N):
    return [0] + [randint(1,50) for _ in range(N)] + [0]
    
def peaks(a):
    p = []
    for i in range(1, len(a)):
        if a[i-1] < a[i] > a[i+1]:
            p.append(a[i])
    return p

N = int(argv[1])
a = make_array(N)
p = peaks(a)
print("Array:", a[1:-1])
print("Peaks:", p)

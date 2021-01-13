from sys import argv

def fact(n):
    res = 1
    for i in range(2, n+1):
        res *= i
    return res

def num_trailing_zeros(n):
    cnt = 0
    pwr = 10
    while n % pwr == 0:
        cnt += 1
        pwr *= 10
    return cnt

n = int(argv[1])
f = fact(n)
z = num_trailing_zeros(f)
zeros = "zero" if z == 1 else "zeros"
print(f"{n} as N! = {f} has {z} trailing {zeros}")

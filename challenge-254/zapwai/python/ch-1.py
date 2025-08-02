def is_pow(n):
    if n == 0:
        return 0
    while(1):
        if n % 3 == 0:
            n = n / 3
            if n == 1:
                return 1
        else:
            return 0

def proc(n):
    print("Input: n =", n)
    print("Output:", is_pow(n))

for n in [27, 0, 6]:
    proc(n)

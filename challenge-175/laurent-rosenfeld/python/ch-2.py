import math

cache = [0] * 10000

def is_perfect_totient (n):
    tot = 0
    for i in range(1, n):
        if (math.gcd(n, i) == 1):
            tot += 1

​ sum = tot + cache[tot] ​ cache[n] = sum ​ return n == sum
​
i = 1 ​ count = 0 ​ while count < 20: ​ if isperfecttotient(i): ​ print(i, end = ” “) ​ count += 1 ​ i += 1 ​ print(” “)

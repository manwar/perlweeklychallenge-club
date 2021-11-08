#!/usr/bin/python3

def is_lychrel(m):
    n = m
    for i in range(500):
        j = int(str(n)[::-1])
        if j == n:
            return 0
        n += j
        if n > 10000000:
            return "n is a lychrel candidate. Reached the 1e7 limit."
    return "n is a lychrel candidate. Made 500 iterations."

for test in range(10, 20):
    print(test, " -> ", is_lychrel(test))

for test in 10, 20, 30, 50, 100, 196:
    print(test, " -> ", is_lychrel(test))

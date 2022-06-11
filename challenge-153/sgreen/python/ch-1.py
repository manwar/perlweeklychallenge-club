#!/usr/bin/env python

import math

def main():
    solutions = [1]
    for i in range(1, 10):
        solutions.append(solutions[-1]+math.factorial(i))

    print(*solutions, sep=', ')

if __name__ ==  '__main__':
    main()
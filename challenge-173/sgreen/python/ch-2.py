#!/usr/bin/env python

import math


def main():
    # Set S0 of 2
    solutions = [2]
    while len(solutions) < 10:
        # The next value is the product of the current array plus one
        solutions.append(math.prod(solutions)+1)

    # Print the solution
    print(*solutions, sep='\n')


if __name__ == '__main__':
    main()

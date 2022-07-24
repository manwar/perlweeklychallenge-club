#!/usr/bin/env python

def is_disarium(n):
    sum = 0

    for count, value in enumerate(str(n)):
        sum += int(value) ** (count+1)

    return sum == n


def main():
    solutions = []
    number = 0

    while len(solutions) < 19:
        if is_disarium(number):
            solutions.append(number)
        number += 1

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()

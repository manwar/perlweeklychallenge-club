#!/usr/bin/env python

def main():
    # Get all squares < 500
    squares = []
    for i in range(2, 23):
        squares.append(i*i)

    # Find all numbers 1 .. 500 that aren't divisable by a square
    solutions = []
    for i in range(1, 501):
        if not any(i % s == 0 for s in squares):
            solutions.append(i)

    print(*solutions, sep=', ')


if __name__ == '__main__':
    main()

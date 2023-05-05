#!/usr/bin/env python
# -*- coding: utf-8 -*-


def is_safe(cube, x, y, z, n):
    # Check row and column
    for i in range(n):
        if cube[x][i][z] or cube[i][y][z]:
            return False

    # Check all layers
    for i in range(n):
        if cube[x][y][i]:
            return False

    # Check diagonals
    for i in range(n):
        for j in range(n):
            for k in range(n):
                if (i + j == x + y) or (i + k == x + z) or (j + k == y + z) or \
                   (i - j == x - y) or (i - k == x - z) or (j - k == y - z):
                    if cube[i][j][k]:
                        return False

    return True


def solve_n_queens_3d(cube, col, n):
    if col >= n:
        return True

    for i in range(n):
        for j in range(n):
            if is_safe(cube, i, j, col, n):
                cube[i][j][col] = 1
                if solve_n_queens_3d(cube, col + 1, n):
                    return True
                cube[i][j][col] = 0

    return False


def n_queens_3d(n):
    cube = [[[0 for _ in range(n)] for _ in range(n)] for _ in range(n)]

    if not solve_n_queens_3d(cube, 0, n):
        print("No solution exists")
        return None

    return cube


if __name__ == "__main__":
    n = 2
    solution = n_queens_3d(n)
    if solution:
        for layer in solution:
            print("Layer:")
            for row in layer:
                print(row)
            print()

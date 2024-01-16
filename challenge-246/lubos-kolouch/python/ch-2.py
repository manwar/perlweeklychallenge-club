#!/usr/bin/env python

import numpy as np


def is_linear_recurrence(a):
    if len(a) < 5:
        return False

    # Forming matrix to solve the linear equations
    A = np.array([[a[0], a[1]], [a[1], a[2]]])
    B = np.array([a[2], a[3]])

    # Solve for p and q
    try:
        p, q = np.linalg.solve(A, B)
    except np.linalg.LinAlgError:
        return False  # Cannot solve if the matrix A is singular

    # Check if p and q are integers
    if not (p.is_integer() and q.is_integer()):
        return False

    # Verify the recurrence for the rest of the array
    for i in range(4, len(a)):
        if a[i] != int(p) * a[i - 2] + int(q) * a[i - 1]:
            return False

    return True


# Tests
assert is_linear_recurrence([1, 1, 2, 3, 5]) == True, "Fibonacci sequence"
assert is_linear_recurrence([4, 2, 4, 5, 7]) == False, "Even-odd mismatch"
assert is_linear_recurrence([4, 1, 2, -3, 8]) == True, "Custom sequence"

# Main
print("true" if is_linear_recurrence([4, 1, 2, -3, 8]) else "false")

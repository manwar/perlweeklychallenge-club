#!/usr/bin/env python3
import math
import unittest

def validate_circle(n):
    solutions = gen_all_circles(n)

    if len(solutions) == 0:
        return 0

    def is_square(num):
        if num < 0:
            return False
        root = int(math.isqrt(num))
        return root * root == num

    for sol_ref in solutions:
        arr = list(sol_ref)

        if len(arr) != n:
            continue

        seen = {}
        has_dup = 0
        for num in arr:
            if num < 1 or num > n or num in seen:
                has_dup = 1
                break
            seen[num] = True

        if has_dup:
            continue

        valid_sums = 1
        for i in range(n):
            current = arr[i]
            next_val = arr[(i + 1) % n]
            if not is_square(current + next_val):
                valid_sums = 0
                break

        if valid_sums:
            return 1

    return 0


def gen_all_circles(n):
    # Precompute perfect squares up to 2 * n
    limit = int(math.sqrt(2 * n))
    squares = {i * i: 1 for i in range(1, limit + 1)}

    all_solutions = []
    path = [1]
    used = [0] * (n + 1)
    used[1] = 1

    def dfs():
        if len(path) == n:
            if (path[-1] + path[0]) in squares:
                all_solutions.append(list(path))
            return

        for next_val in range(2, n + 1):
            if used[next_val] or (path[-1] + next_val) not in squares:
                continue

            used[next_val] = 1
            path.append(next_val)

            dfs()

            used[next_val] = 0
            path.pop()

    dfs()
    return all_solutions


# --- UNIT TEST CASE ---
class TestSquareSumCircle(unittest.TestCase):
    def test_square_sum_circles(self):
        examples = [
            {"in": 32, "out": 1},
            {"in": 15, "out": 0},
            {"in": 34, "out": 1},
        ]

        for ex in examples:
            # Use subTest so a failure in one example doesn't stop the others from running
            with self.subTest(n=ex["in"]):
                self.assertEqual(validate_circle(ex["in"]), ex["out"])


if __name__ == "__main__":
    unittest.main()

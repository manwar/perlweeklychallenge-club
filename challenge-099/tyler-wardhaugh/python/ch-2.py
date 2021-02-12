#!/usr/bin/env python3
"""Challenge 99, Task 2"""

import sys
import numpy as np


DEFAULT_INPUT = ('littleit', 'lit')


def unique_subsequences(s, t):
    """Use a dynamic programming algorithm to solve unique subsequences.
       Source: https://www.geeksforgeeks.org/count-distinct-occurrences-as-a-subsequence/"""

    m = len(t)
    n = len(s)

    if m > n:
        return 0

    # NumPy is overkill for this use case, especially since we're not taking
    # advantage of any high-performance array manipulations, but I wanted to
    # show its use.
    dp = np.zeros((m + 1, n + 1), dtype=int)
    dp[0, :] = np.ones(n + 1)

    with np.nditer(dp, flags=['multi_index'], order='C') as it:
        while not it.finished:
            i, j = it.multi_index
            it.iternext()

            if i == 0 or j == 0:
                continue

            if t[i - 1] != s[j - 1]:
                dp[i][j] = dp[i][j - 1]
            else:
                dp[i][j] = dp[i][j - 1] + dp[i - 1][j - 1]

    return dp[m][n]


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    s, t = args[0:1] if args else DEFAULT_INPUT
    print(unique_subsequences(s, t))


if __name__ == '__main__':
    sys.exit(main())

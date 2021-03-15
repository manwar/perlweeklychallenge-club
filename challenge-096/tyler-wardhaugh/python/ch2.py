#!/usr/bin/env python3
"""Challenge 96, Task 2"""

import sys
import numpy as np


DEFAULT_INPUT = ["kitten", "sitting"]


def edit_distance(s1, s2):
    """Determine the edit distance between two strings."""
    dp = np.zeros((len(s1), len(s2)), dtype=np.int)
    for i, j in np.ndindex(dp.shape):
        if i == 0:
            dp[i][j] = j
        elif j == 0:
            dp[i][j] = i
        elif s1[i - 1] == s2[j - 1]:
            dp[i][j] = dp[i - 1][j - 1]
        else:
            dp[i][j] = 1 + min(dp[i][j - 1],
                               dp[i - 1][j],
                               dp[i - 1][j - 1])

    return dp[-1][-1]


def main(args=None):
    """Run the task"""
    if args is None:
        args = sys.argv[1:]

    if args:
        s1, s2 = args[0:2]
    else:
        s1, s2 = DEFAULT_INPUT

    print(edit_distance(s1, s2))


if __name__ == '__main__':
    sys.exit(main())

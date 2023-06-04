#!/usr/bin/env python
# -*- coding: utf-8 -*-

def min_cost(costs, days):
    N = max(days) + 1
    dp = [0]*N
    days = set(days)
    for i in range(1, N):
        if i not in days:
            dp[i] = dp[i-1]
        else:
            dp[i] = min(
                dp[i-1] + costs[0],
                dp[max(0, i-7)] + costs[1],
                dp[max(0, i-30)] + costs[2]
            )
    return dp[-1]


# Tests
print(min_cost([2, 7, 25], [1, 5, 6, 7, 9, 15]))  # Output: 11
# Output: 20
print(min_cost([2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]))

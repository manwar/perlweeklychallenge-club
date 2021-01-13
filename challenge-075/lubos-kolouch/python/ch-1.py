#!/usr/bin/env python
""" Perl weekly challenge 075 Task 1 - Coins sum """


def count(coins, target_sum):
    """ count the ways we can sum coins """

    ways = [0] * (target_sum + 1)

    ways[0] = 1

    for value in coins:
        for j, _ in enumerate(ways):
            if value <= j:
                ways[j] += ways[j - value]

    return ways[target_sum]


assert count([1, 2, 4], 6) == 6
assert count([1, 5, 10], 12) == 4

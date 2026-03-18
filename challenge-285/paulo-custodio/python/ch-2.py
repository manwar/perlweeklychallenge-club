#!/usr/bin/env python3

# Perl Weekly Challenge 285 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-285/

import sys

COINS = [50,25,10,5,1]

def compute_num_ways(amount, coins):
    while len(coins) > 1 and coins[0] > amount:
        coins = coins[1:]
    if len(coins) == 1:
        return 1
    count = 0
    for v in range(0, amount+1, coins[0]):
        count += compute_num_ways(amount-v, coins[1:])
    return count

print(compute_num_ways(int(sys.argv[1]), COINS))

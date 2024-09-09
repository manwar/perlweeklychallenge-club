#!/usr/bin/env python3

# Challenge 285
#
# Task 2: Making Change
# Submitted by: David Ferrone
#
# Compute the number of ways to make change for given amount in cents. By using
# the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many
# distinct ways can the total value equal to the given amount? Order of coin
# selection does not matter.
#
# A penny (P) is equal to 1 cent.
# A nickel (N) is equal to 5 cents.
# A dime (D) is equal to 10 cents.
# A quarter (Q) is equal to 25 cents.
# A half-dollar (HD) is equal to 50 cents.
#
# Example 1
#
# Input: $amount = 9
# Ouput: 2
#
# 1: 9P
# 2: N + 4P
#
# Example 2
#
# Input: $amount = 15
# Ouput: 6
#
# 1: D + 5P
# 2: D + N
# 3: 3N
# 4: 2N + 5P
# 5: N + 10P
# 6: 15P
#
# Example 3
#
# Input: $amount = 100
# Ouput: 292

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

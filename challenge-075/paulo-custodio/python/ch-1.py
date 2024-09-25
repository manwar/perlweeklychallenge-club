#!/usr/bin/env python3

# Challenge 075
#
# TASK #1 > Coins Sum
# Submitted by: Mohammad S Anwar
# You are given a set of coins @C, assuming you have infinite amount of each
# coin in the set.
#
# Write a script to find how many ways you make sum $S using the coins from
# the set @C.
#
# Example:
# Input:
#     @C = (1, 2, 4)
#     $S = 6
#
# Output: 6
# There are 6 possible ways to make sum 6.
# a) (1, 1, 1, 1, 1, 1)
# b) (1, 1, 1, 1, 2)
# c) (1, 1, 2, 2)
# d) (1, 1, 4)
# e) (2, 2, 2)
# f) (2, 4)

import sys

def show_coins(want, coins):
    def show_coins1(want, have, coins, seen):
        sum_have = sum(have)
        if sum_have > want:
            pass            # busted sum
        elif sum_have == want:
            out = ", ".join([str(x) for x in sorted(have)])
            if not out in seen:
                seen[out] = 1
                print(out)
        else:
            for coin in coins:
                show_coins1(want, have+[coin], coins, seen)

    show_coins1(want, [], coins, {})

S = int(sys.argv[1])
C = [int(x) for x in sys.argv[2:]]
show_coins(S, C)

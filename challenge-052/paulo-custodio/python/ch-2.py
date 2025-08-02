#!/usr/bin/env python3

# Challenge 052
#
# TASK #2
# Lucky Winner
# Suppose there are following coins arranged on a table in a line in random
# order.
#
# Pound1, 50p, 1p, 10p, 5p, 20p, Pound2, 2p
#
# Suppose you are playing against the computer. Player can only pick one coin
# at a time from either ends. Find out the lucky winner, who has the larger
# amounts in total?

from random import shuffle

coins = [100, 50, 1, 10, 5, 20, 200, 2]
shuffle(coins)

human = 0
computer = 0

while len(coins) > 0:
    # human
    draw = ""
    while draw != "b" and draw != "e":
        draw = input("Coins: "+" ".join([str(x) for x in coins])+". draw (b/e)? ")
    if draw == "b":
        human += coins[0]
        coins = coins[1:]
    else:
        human += coins[-1]
        coins = coins[:-1]

    # computer
    if len(coins) > 0:
        if coins[0] >= coins[-1]:
            computer += coins[0]
            coins = coins[1:]
        else:
            computer += coins[-1]
            coins = coins[:-1]

if human > computer:
    print(f"You WIN ({human}/{computer})")
else:
    print(f"You LOOSE ({human}/{computer})")

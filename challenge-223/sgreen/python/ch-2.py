#!/usr/bin/env python3

import sys


def collect_coins(coins):
    # If we only have one coin left, use that
    if len(coins) == 1:
        return coins[0]

    remaining_coins = len(coins)
    collections = []

    for i in range(remaining_coins):
        # Work out how many coins we collect when we remove this coin
        collect = coins[i]
        if i > 0:
            collect *= coins[i-1]
        if i < remaining_coins - 1:
            collect *= coins[i+1]

        # Create a new list without this coin
        new_coins = coins.copy()
        del new_coins[i]
        # ... and call the function again
        collect += collect_coins(new_coins)

        collections.append(collect)

    # Return the best score
    return max(collections)


def main(coins):
    print(collect_coins(coins))


if __name__ == '__main__':
    # Convert input into integers
    coins = [int(n) for n in sys.argv[1:]]
    main(coins)

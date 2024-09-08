#!/usr/bin/env python3

import sys


def making_change(remaining: int, last_coin: int | None = None) -> int:
    combinations = 0

    for coin in [1, 5, 10, 25, 50]:
        if last_coin and last_coin < coin:
            # We can't use a larger coin that the last one
            continue
        if coin == remaining:
            # We have found a solution
            combinations += 1
        if coin < remaining:
            # Call the function again, taking away the value of the coin
            combinations += making_change(remaining-coin, coin)

    # This value is returned upstream as we go
    return combinations


def main():
    result = making_change(int(sys.argv[1]))
    print(result)


if __name__ == '__main__':
    main()

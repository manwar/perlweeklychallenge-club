#!/usr/bin/env python3

import sys


def final_price(prices: list) -> list:
    """
    Function to calculate the final price of items after applying discounts.
    :param prices: List of integers representing item prices
    :return: List of final prices after discounts
    """
    solution = []
    for i in range(len(prices)):
        discount = 0
        for j in range(i + 1, len(prices)):
            if prices[j] <= prices[i]:
                discount = prices[j]
                break
        solution.append(prices[i] - discount)

    return solution


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = final_price(array)
    print(result)


if __name__ == '__main__':
    main()

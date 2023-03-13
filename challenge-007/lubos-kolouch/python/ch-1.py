#!/usr/bin/env python
# -*- coding: utf-8 -*-

def sum_of_digits(number: int) -> int:
    """Return the sum of digits of a given number."""
    total = 0
    while number > 0:
        total += number % 10
        number //= 10
    return total


def print_niven_numbers() -> None:
    """Print all the niven numbers from 0 to 50 inclusive."""
    for num in range(51):
        digit_sum = sum_of_digits(num)
        if digit_sum != 0 and num % digit_sum == 0:
            print(num)


if __name__ == '__main__':
    print_niven_numbers()

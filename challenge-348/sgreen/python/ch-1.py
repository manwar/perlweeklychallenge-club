#!/usr/bin/env python3

import sys


def count_vowels(s: str) -> int:
    vowels = 'aeiouAEIOU'
    return sum(1 for char in s if char in vowels)

def string_alike(input_string: str) -> bool:
    # Ensure the input string is of even length
    if len(input_string) % 2 == 1:
        raise ValueError("Input string must have an even length.")

    if count_vowels(input_string) == 0:
        return False

    # Split the string into two halves, and count vowels in each half
    first_half = input_string[:len(input_string)//2]
    second_half = input_string[len(input_string)//2:]
    return count_vowels(first_half) == count_vowels(second_half)

def main():
    result = string_alike(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()

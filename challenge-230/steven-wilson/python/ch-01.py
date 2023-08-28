#!/usr/bin/env python3


def separate_digits(*elements):
    return [int(char) for elem in elements for char in str(elem)]


if __name__ == "__main__":
    print(separate_digits(1, 34, 5, 6))
    print(separate_digits(1, 24, 51, 60))

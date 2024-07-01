#!/usr/bin/env python3

from collections import Counter
import sys


def maximum_frequency(ints: list) -> str:
    """
    Calculate the maximum frequency of elements in a list and returns the
    number of elements with that appear with this frequency.

    Args:
        ints (list): A list of integers.

    Returns:
        str: The number of elements with appear most frequency.
    """
    # Convert the list in a frequency dictionary
    freq = Counter(ints)
    max_freq = max(freq.values())

    # Count the number of elements with the maximum frequency
    elements = sum(1 for v in freq.values() if v == max_freq)

    # Multiply the number of elements by the frequency
    return elements * max_freq


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = maximum_frequency(array)
    print(result)


if __name__ == '__main__':
    main()

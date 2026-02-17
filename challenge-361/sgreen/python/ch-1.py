#!/usr/bin/env python3

import sys


def generate_fibonacci(number: int) -> list[int]:
    """Generate list of fibonacci numbers, up to an including a specified number

    Params:
        number(int): The target number

    Returns:
        list[int]: The fibonacci numbers <= number
    """

    # Seed the sequence
    seq = [0, 1]

    # Add to the sequence until we exceed the number
    while seq[-1] <= number:
        seq.append(seq[-2] + seq[-1])

    # Remove largest number which will be greater than the target
    return seq[:-1]


def zeckendorf_representation(number: int) -> list[int] | None:
    """
    Generate the Zeckendorf Representation of the given integer. Every positive
    integer can be uniquely represented as sum of non-consecutive Fibonacci
    numbers.

    Params:
        number(int): The target number

    Returns:
        list[int]: The numbers that make up the sequence, highest first
    """

    if number < 1:
        # Check we have a positive integer
        raise ValueError("The number must be a positive integer")

    # Generate a list of fibonacci numbers <= number
    seq = generate_fibonacci(number)

    remaining = number
    result = []

    while seq:
        # Remove the highest remaining value from the sequence
        value = seq.pop()

        # If it is > what is remaining, we skip it
        if value <= remaining:
            # Reduce the remaining value and add to the result list
            remaining -= value
            result.append(value)

            if remaining == 0:
                # The target has been reached
                return result

            # Remove the next value from the sequence, as we cannot use
            #  consecutive numbers
            seq.pop()

    # We should never reach here
    return None


def main():
    # Convert input into integers
    result = zeckendorf_representation(int(sys.argv[1]))
    print(result)


if __name__ == "__main__":
    main()

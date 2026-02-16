#!/usr/bin/env python3

"""While this solution is valid, it is slightly inefficient"""

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

    # Add to it until we exceed the number
    while seq[-1] <= number:
        seq.append(seq[-2] + seq[-1])

    # Return the list with largest number first
    # Remove largest number which will be greater than the target
    return seq[-2::-1]


def find_rep(pool: list[int], considering: list[int] | None, target: int) -> list[int] | None:
    """
    Recursive function to consider all possible combinations of numbers to reach a target

    Params:
        pool list[int]: A list of numbers to consider
        considering list[int]: The current list of numbers we are considering
        target int: The target we are trying to reach

    Returns:
        list[int]: The list of numbers to reach the target, or None if the pool is exhausted
    """

    if considering is None:
        considering = []

    if pool is None:
        # We've exhausted all numbers, but haven't find a solution
        return None

    for idx in range(len(pool)):
        now_considering = [*considering, pool[idx]]
        total = sum(now_considering)
        if total == target:
            # We have the best answer
            return now_considering
        if total < target:
            # We need to add more numbers
            solution = find_rep(pool[idx+2:], now_considering, target)
            if solution is not None:
                return solution

    return None


def zeckendorf_representation(number: int) -> list[int] | None:
    if number < 1:
        raise ValueError("The number must be a positive integer")

    seq = generate_fibonacci(number)
    return find_rep(seq, None, number)


def main():
    # Convert input into integers
    result = zeckendorf_representation(int(sys.argv[1]))
    print(result)


if __name__ == "__main__":
    main()

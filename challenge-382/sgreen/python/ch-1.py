#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge" ""

import sys

SQUARES = None


def hamiltonian_cycle(n: int, results=None) -> list[int]:
    """
    Arrange all the whole numbers from 1 up to the given target number into a circle so that every pair of side-by-side numbers adds up to a perfect square

    Parameters:
        n (int): The target number
        results (list[int]): The results so far

    Returns:
        list: The numbers that make up a valid result, or an empty list if there is none
    """
    global SQUARES

    if SQUARES is None:
        # Compute once
        SQUARES = {n * n for n in range(1, n + 1)}

    if results is None:
        # First call, always start with one
        results = [1]

    remaining_numbers = [n for n in range(2, n + 1) if n not in results]
    if not remaining_numbers:
        # We have exhausted the list
        if results[0] + results[-1] in SQUARES:
            # Check the first and last number is also a square
            return results

        # Try and find another solution
        return []

    for i in remaining_numbers:
        if i + results[-1] in SQUARES:
            # This and the last number in the list are a square, call the function again.
            new_results = hamiltonian_cycle(n, results + [i])
            if new_results:
                return new_results

    return []


def main():
    """Convert command line input into parameters for the function and display result"""
    result = hamiltonian_cycle(int(sys.argv[1]))
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()

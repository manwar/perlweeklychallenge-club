#!/usr/bin/env python3

from more_itertools import distinct_permutations
import sys


def dictionary_rank(word: str) -> int:
    """Calculate the position on the dictionary if all permutations of letters
    in the given word were valid.

    Args:
        word (str): The input word

    Returns:
        int: The position
    """
    # Convert to lower case, and sort the letters alphabetically
    tuple_word = tuple(word.lower())
    letters = sorted(tuple_word)
    count = 0

    # Go through each sorted unique permutation until we find the word we want
    for perm in distinct_permutations(letters):
        count += 1
        if perm == tuple_word:
            break
    else:
        raise ValueError('Cannot find position')

    # Return the rank
    return count


def main():
    # Convert input into integers
    result = dictionary_rank(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()

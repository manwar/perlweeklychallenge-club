#!/usr/bin/env python3

import sys


def reverse_equal(list1: list[int], list2: list[int]) -> bool:
    if list1 == list2:
        # Reversing a single value is a noop (list remains unchanged)
        return True

    if len(list1) != len(list2):
        # Check lists are of the same length
        raise ValueError('Lists must be of the same length')

    if u := set(list1) ^ set(list2):
        # Check that all items appear in both lists
        raise ValueError(
            f"These items don't appear in both lists: {', '.join(u)}")

    if sum(list1) != sum(list2):
        # Check that the sun is the the same. This avoids two of one and two
        #  of another that the previous check misses.
        raise ValueError("The list does not container the same values")

    for start in range(len(list1)-1):
        for stop in range(start+2, len(list1)+1):
            # Reverse the items from start to stop-1 in list2
            new_list = list2.copy()
            new_list[start:stop] = list(reversed(new_list[start:stop]))

            # .. and compare it to list1
            if new_list == list1:
                return True

    return False


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    half_count = len(array) // 2
    result = reverse_equal(array[:half_count], array[half_count:])
    print(result)


if __name__ == '__main__':
    main()

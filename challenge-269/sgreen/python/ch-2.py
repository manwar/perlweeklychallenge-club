#!/usr/bin/env python3

import sys


def distribute_elements(ints: list) -> list:
    # Take the first two integers to seed each array
    arr1 = [ints.pop(0)]
    arr2 = [ints.pop(0)]

    while ints:
        # If the lasst element in the first list is greater than the last
        #  element in the second list
        if arr1[-1] > arr2[-1]:
            # ... add it to the first list
            arr1.append(ints.pop(0))
        else:
            # ... else add it to the second list
            arr2.append(ints.pop(0))

    # Join the arrays together
    return arr1 + arr2


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = distribute_elements(array)
    print('(' + ', '.join(map(str, result)) + ')')


if __name__ == '__main__':
    main()

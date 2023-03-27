#!/usr/bin/env python3

import sys


def main(array):
    # Continue until we can't
    should_continue = True

    while should_continue:
        # Go through each item in the array, get that value and the next
        for i in range(len(array)-1):
            left = array[i]
            right = array[i+1]

            # If the left value is > 0 and the right one is < 0, we have
            #  a collision
            if left > 0 and right < 0:
                right = abs(right)
                if right <= left:
                    # Remove the right number
                    array.pop(i+1)
                if right >= left:
                    # Remove the left number
                    array.pop(i)

                # Start the loop again
                break
        else:
            # We've gone through the list and removed all collisions
            should_continue = False

    print(array)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)

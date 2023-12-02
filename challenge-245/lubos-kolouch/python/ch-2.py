#!/usr/bin/env python


def largest_multiple_of_three(ints):
    # Sort numbers in descending order
    ints.sort(reverse=True)

    # Function to calculate the sum of digits
    sum_digits = sum(ints)

    # Function to remove the smallest element with a specified remainder
    def remove_smallest(remainder):
        for i in range(len(ints) - 1, -1, -1):
            if ints[i] % 3 == remainder:
                del ints[i]
                return True
        return False

    # Adjust the list to make the sum of its digits divisible by 3
    if sum_digits % 3 == 1:
        # Try to remove one number with a remainder of 1, else remove two with a remainder of 2
        if not remove_smallest(1):
            remove_smallest(2) and remove_smallest(2)
    elif sum_digits % 3 == 2:
        # Try to remove one number with a remainder of 2, else remove two with a remainder of 1
        if not remove_smallest(2):
            remove_smallest(1) and remove_smallest(1)

    return int("".join(map(str, ints))) if ints and sum(ints) % 3 == 0 else -1


# Test Cases
test1 = largest_multiple_of_three([8, 1, 9]) == 981
test2 = largest_multiple_of_three([8, 6, 7, 1, 0]) == 8760
test3 = largest_multiple_of_three([1]) == -1

test1, test2, test3

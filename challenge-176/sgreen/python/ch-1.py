#!/usr/bin/env python3

def sort_number(num):
    '''Sort the digits numerically. Returns a string'''
    return ''.join(sorted(str(num)))


def main():
    num = 1

    # Start incrementing until we have a solution
    while True:
        # The easiest way to see if a number is a permentation of the digits
        #  is to sort it numerically.
        sorted_num = sort_number(num)
        is_permuted = True

        for i in range(2, 7):
            # If the product is not a permutation of the number, exit the inner loop
            if sort_number(i * num) != sorted_num:
                is_permuted = False
                break

        if is_permuted == True:
            # We have a solution
            print(num)
            return

        num += 1


if __name__ == '__main__':
    main()

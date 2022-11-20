#!/usr/bin/env python3

import sys

def find_solutions(front, back):
    '''Recursive function to find possible solutions. Front is the numbers we
       have processed, back is what remains'''
    if len(back) == 0:
        return 1

    # Iterate over the next value
    count = 0
    for i in back[0]:
        # Call the recursive function if we haven't used this number already
        if i not in front:
            count += find_solutions([*front, i], back[1:])

    # Return the number of matches up the recursive function
    return count

def main(n):
    '''Main function'''
    # Generate a list of list with a possible value for each number
    possible = []
    for i in range(1, n+1):
        possible.append([j for j in range(1, n+1) if j % i == 0 or i % j == 0])

    print(find_solutions([], possible))


if __name__ == '__main__':
    main(int(sys.argv[1]))

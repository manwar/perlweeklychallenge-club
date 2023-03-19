#!/usr/bin/env python3

import re
import sys


def find_index_in_list(array, word):
    '''Find the index of a word in a list'''
    for i, w in enumerate(array):
        if w == word:
            return i

    # This word does not appear in the list
    return None


def main(first_list, second_list):
    # Turn the words into a list
    first_list = re.findall(r'\w+', first_list)
    second_list = re.findall(r'\w+', second_list)

    # We set the index_sum to one more than the greatest possible solution
    index_sum = len(first_list) + len(second_list) + 1
    solution = []

    # Loop through the first_list
    for i1, w in enumerate(first_list):
        # See if it appears in the second list
        i2 = find_index_in_list(second_list, w)
        if i2 is not None:
            # The the index sum of this word
            i = i1 + i2
            if i < index_sum:
                # It is better than the previous solution
                solution = [w]
                index_sum = i
            elif i == index_sum:
                # It is the same as the previous solution
                solution.append(w)

    # Print the results
    if solution:
        print('("' + '", "'.join(solution) + '")')
    else:
        print('()')


if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])

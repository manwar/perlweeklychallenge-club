#!/usr/bin/env python

import sys

def shrink_list(array):
    '''Shrink the list if it has consecutive numbers'''
    new_array = []
    for i in array:
        number, count = i
        if len(new_array) and new_array[-1][0] == number:
            new_array[-1] = (number, count + new_array[-1][1])
        else:
            new_array.append((number, count))

    return new_array

def score_array(array):
    '''Recursive function to get the highest score'''
    # Shrink the list if it has consecutive numbers
    array = shrink_list(array)

    if len(array) == 1:
        # There is only one remaining number
        return array[0][1] ** 2
    
    max_score = 0

    for i, tup in enumerate(array):
        # Create a copy of the array without the chosen element
        new_array = array.copy()
        del new_array[i]

        # Calculate the maximum possible score recursively
        score = tup[1] ** 2 + score_array(new_array)
        if score > max_score:
            max_score = score

    # Return the maximum score
    return max_score

def main(array):
    # Turn the list in a list of tuples of the number and the occurrences of it
    array = [ (x, 1) for x in array]
    score = score_array(array)
    print(score)

if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)

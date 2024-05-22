#!/usr/bin/env python3


def distribute_elements(integers, x, y):
    ''' Given an array of integers and two integers, x and y, execute one of
    the two options:

        Level 1:
        Pick an index i of the given array and do integers[i] += 1

        Level 2:
        Pick two different indices i,j and do integers[i] +=1 and integers[j] += 1.

    You are allowed to perform as many levels as you want to make every
    elements in the given array equal. There is cost attach for each level,
    for Level 1, the cost is $x and $y for Level 2.

    In the end return the minimum cost to get the work done.

    >>> distribute_elements([4, 1], x=3, y=2)
    9
    >>> distribute_elements([2, 3, 3, 3, 5], x=2, y=1)
    6
    >>> distribute_elements([4, 4, 2, 6], x=3, y=1)
    4
    '''
    integers = sorted(integers)
    max_int = integers[-1]
    level_1_preferred = (x * 2 < y)
    cost = 0
    positions = [i for i, v in enumerate(integers) if v < max_int]
    while positions:
        if len(positions) > 1 and not level_1_preferred:
            i, j = positions[:2]
            integers[i] += 1
            integers[j] += 1
            cost += y
            if integers[j] == max_int:
                del positions[1]
            if integers[i] == max_int:
                del positions[0]
        else:
            i = positions[0]
            integers[i] += 1
            cost += x
            if integers[i] == max_int:
                del positions[0]
    return cost


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)

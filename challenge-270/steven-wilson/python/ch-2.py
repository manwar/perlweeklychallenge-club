#!/usr/bin/env python3

import heapq


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
    >>> distribute_elements([1, 1, 1, 6], x=3, y=1)
    10
    '''
    heapq.heapify(integers)
    max_int = heapq.nlargest(1, integers)[0]
    level_1_preferred = (x * 2 < y)
    cost = 0
    while integers[0] != max_int:
        if heapq.nsmallest(2, integers)[1] < max_int and not level_1_preferred:
            smallest = heapq.heappop(integers) + 1
            next_smallest = heapq.heappop(integers) + 1
            heapq.heappush(integers, smallest)
            heapq.heappush(integers, next_smallest)
            cost += y
        else:
            heapq.heappush(integers, heapq.heappop(integers) + 1)
            cost += x
    return cost


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)

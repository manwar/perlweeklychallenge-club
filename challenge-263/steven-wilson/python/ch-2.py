#!/usr/bin/env python3

from collections import Counter


def merge_items(items1, items2):
    ''' Given two 2-D array of positive integers, items1 and items2 where
    element is pair of (item_id, item_quantity), return the merged items.
    >>> merge_items([ [1,1], [2,1], [3,2] ], [ [2,2], [1,3] ])
    [[1, 4], [2, 3], [3, 2]]
    >>> merge_items([[1, 2], [2, 3], [1, 3], [3, 2]], [[3, 1], [1, 3]])
    [[1, 8], [2, 3], [3, 3]]
    >>> merge_items([[1, 1], [2, 2], [3, 3]], [[2, 3], [2, 4]])
    [[1, 1], [2, 9], [3, 3]]
    '''
    counter = Counter()
    all_items = items1 + items2

    for item in all_items:
        counter[item[0]] += item[1]

    return [[item_id, counter[item_id]] for item_id in sorted(counter.keys())]


if __name__ == "__main__":
    import doctest

    doctest.testmod()

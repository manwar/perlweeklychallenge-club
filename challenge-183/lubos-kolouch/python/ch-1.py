#!/usr/bin/env python
# -*- coding: utf-8 -*-


def remove_duplicates(lst):
    # Convert each list to a tuple so it can be added to a set
    tuples = [tuple(i) for i in lst]
    # Create a set to remove duplicates, then convert each tuple back to a list
    return [list(i) for i in set(tuples)]


list1 = [[1, 2], [3, 4], [5, 6], [1, 2]]
list2 = [[9, 1], [3, 7], [2, 5], [2, 5]]

print(remove_duplicates(list1))  # Output: [[1, 2], [3, 4], [5, 6]]
print(remove_duplicates(list2))  # Output: [[9, 1], [2, 5], [3, 7]]

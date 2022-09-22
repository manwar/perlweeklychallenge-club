#!/usr/bin/env python3

# You are given list of arrayrefs.
# Write a script to remove the duplicate arrayrefs from the given list.
import numpy as np


def remove_dup_arrayrefs_from_list(list_array_refs):
    length_array = len(list_array_refs)
    i = 0
    while i < (length_array - 1):
        j = i + 1
        list_dups = []
        while j < length_array:
            if (np.array_equiv(list_array_refs[i], list_array_refs[j])):
                list_dups.append(j)
            j += 1
        i += 1
        if list_dups:
            for d in reversed(list_dups):
                list_array_refs.pop(d)
            length_array = length_array - len(list_dups)
    return list_array_refs


if __name__ == "__main__":
    list1 = [[1, 2], [3, 4], [5, 6], [1, 2]]
    print(list1)
    print(remove_dup_arrayrefs_from_list(list1))
    list2 = [[9, 1], [3, 7], [2, 5], [2, 5]]
    print(list2)
    print(remove_dup_arrayrefs_from_list(list2))
    list3 = [[1, 2], [1, 2], [3, 4], [5, 6]]  # duplicates at the beginning
    print(list3)
    print(remove_dup_arrayrefs_from_list(list3))
    list4 = [[9, 1], [3, 7], [2, 5], [2, 5], [2, 5], [3, 7]]  # more than 2 the same
    print(list4)
    print(remove_dup_arrayrefs_from_list(list4))

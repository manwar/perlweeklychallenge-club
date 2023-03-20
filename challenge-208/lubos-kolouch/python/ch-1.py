#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def find_common_strings(list1: List[str], list2: List[str]) -> List[str]:
    """
    Finds all common strings in the given two arrays with minimum index sum.
    If no common strings are found, returns an empty list.
    Args:
        list1: The first list of strings
        list2: The second list of strings
    Returns:
        A list of common strings with minimum index sum, or an empty list if no common strings are found.
    """
    common = {}
    min_index_sum = len(list1) + len(list2)
    for i, elem1 in enumerate(list1):
        for j, elem2 in enumerate(list2):
            if elem1 == elem2:
                index_sum = i + j
                if index_sum <= min_index_sum:
                    min_index_sum = index_sum
                    common[list1[i]] = index_sum

    result = []
    for key in common.keys():
        if common[key] == min_index_sum:
            result.append(key)

    return result


# Tests


def test_find_common_strings():
    list1_1 = ["Perl", "Raku", "Love"]
    list2_1 = ["Raku", "Perl", "Hate"]
    common_1 = find_common_strings(list1_1, list2_1)
    assert common_1 == ["Perl", "Raku"]

    list1_2 = ["A", "B", "C"]
    list2_2 = ["D", "E", "F"]
    common_2 = find_common_strings(list1_2, list2_2)
    assert common_2 == []

    list1_3 = ["A", "B", "C"]
    list2_3 = ["C", "A", "B"]
    common_3 = find_common_strings(list1_3, list2_3)
    assert common_3 == ["A"]

    print("All tests pass")


if __name__ == "__main__":
    test_find_common_strings()

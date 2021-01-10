#!env python
"""
# ===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge 094
#               Task 1
#               Group Anagrams
#
#       AUTHOR: Lubos Kolouch
#      VERSION: 1.0
#      CREATED: 01/06/2021 08:43:01 PM
# ===============================================================================
"""
from collections import defaultdict


def get_anagrams(what):
    """ Sort and group """

    group = defaultdict(list)

    for elem in what:
        joined = ''.join(sorted(elem))
        group[joined].append(elem)

    return list(group.values())


def test_case1():
    """ Test case 1 from the web """
    result = get_anagrams(["opt", "bat", "saw", "tab", "pot", "top", "was"])
    assert result == [['opt', 'pot', 'top'], ['bat', 'tab'], ['saw', 'was']]


def test_case2():
    """ Test case 2 from the web """
    result = get_anagrams(["x"])
    assert result == [['x']]

#!/usr/bin/env python3

'''

Week 188:
    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #1: Divisible Pairs

    You are given list of integers @list of size $n and divisor $k.
    Write a script to find out count of pairs in the given list that
    satisfies the following rules.
    The pair (i, j) is eligible if and only if
    a) 0 <= i < j < len(list)
    b) list[i] + list[j] is divisible by k

'''

def count_divisibles(list, k):
    divisibles_count = 0
    list_size = len(list)

    for i in range(list_size):
        for j in range(i+1, list_size):
            if ((list[i] + list[j]) %k == 0):
                divisibles_count += 1

    return divisibles_count

def test_count_divisibles():

    assert count_divisibles([4, 5, 1, 6], 2) == 2, 'Example 1 Failed'
    assert count_divisibles([1, 2, 3, 4], 2) == 2, 'Example 2 Failed'
    assert count_divisibles([1, 3, 4, 5], 3) == 2, 'Example 3 Failed'
    assert count_divisibles([5, 1, 2, 3], 4) == 2, 'Example 4 Failed'
    assert count_divisibles([7, 2, 4, 5], 4) == 1, 'Example 5 Failed'

test_count_divisibles()

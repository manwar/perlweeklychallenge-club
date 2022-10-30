#!/usr/bin/env python3

'''

Week 188:
    https://theweeklychallenge.org/blog/perl-weekly-challenge-188

Task #2: Total Zero
    You are given two positive integers $x and $y.
    Write a script to find out the number of operations needed to
    make both ZERO. Each operator is made up either of the following:
        $x = $x - $y if $x >= $y
        or
        $y = $y - $x if $y >= $x

'''

def total_zero(x, y):
    operations_count = 0

    while (x > 0 and y > 0):

        if x >= y: x -= y
        else: y -= x

        operations_count += 1

    return operations_count

def test_total_zero():
    assert total_zero(5, 4) == 5, 'Example 1 Failed';
    assert total_zero(4, 6) == 3, 'Example 2 Failed';
    assert total_zero(2, 5) == 4, 'Example 3 Failed';
    assert total_zero(3, 1) == 3, 'Example 4 Failed';
    assert total_zero(7, 4) == 5, 'Example 5 Failed';

test_total_zero()

"""
 Week 192:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-193

    Task 1: Binary String
    Submitted by: Mohammad S Anwar
    You are given an integer, $n > 0.

    Write a script to find all possible binary numbers of size $n.
"""

def binaryString(binary_string_size):
    return [bin(i)[2:].zfill(binary_string_size) for i in range(pow(2, binary_string_size))]

def binaryStringTest():
    assert binaryString(2) == ['00', '01', '10', '11'], 'Example 1 Failed.'
    assert binaryString(3) == ['000', '001', '010', '011', '100', '101', '110', '111'], 'Example 2 Failed.'

binaryStringTest()
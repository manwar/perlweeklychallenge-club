#!/bin/env python
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-088/
#               Task 1
#  		Array of Product
#
#       AUTHOR: Lubos Kolouch 
#      VERSION: 1.0
#      CREATED: 11/28/2020 01:02:17 PM
#===============================================================================
from operator import mul

def get_product(in_arr):
    """ Get the product as required """

    product = 1
    for i in in_arr:
        product *= i

    out_arr = []

    for item in in_arr:
        out_arr.append( product // item )

    return out_arr


assert get_product([5, 2, 1, 4, 3]) == [24, 60, 120, 30, 40]
assert get_product([2, 1, 4, 3]) == [12, 24, 6, 8]

#!/bin/env python
""" ===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py 
#
#  DESCRIPTION: Perl Weekly Challenge 081
#  				https://perlweeklychallenge.org/blog/perl-weekly-challenge-081/
#  				Task 1 - Common base string 
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 10/09/2020 10:43:10 AM
#===============================================================================
"""
import re


def get_common_strings(str1, str2):
    """ Find and return the common strings """

    result = []
    res1 = re.match(r'(.*)\1+', str1)

    result.append(res1.group(1))

    res2 = re.match(r'(.*)\1+', str2)
    if res1.group(1) != res2.group(1):
        result.append(res2.group(1))

    return result


assert get_common_strings('abcdabcd', 'abcdabcdabcdabcd') == ['abcd','abcdabcd']
assert get_common_strings('aaa', 'aa') == ['a']
assert get_common_strings('abc', 'aa') == ['','a']

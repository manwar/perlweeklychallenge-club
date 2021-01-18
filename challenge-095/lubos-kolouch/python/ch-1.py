#!env python
"""
# ===============================================================================
#
#         FILE: ch_2.py
#
#        USAGE: ./ch_2.py
#
#  DESCRIPTION: Perl Weekly Challenge #095
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-095/
#               Palindrome Number
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 01/13/2021 02:39:16 PM
#===============================================================================
"""


def is_palindrome(what: int):
    """ test the palindrome """

    # the 0+ is to avoid situations like 0000123
    return str(what+0) == str(what+0)[::-1]


def test_numbers():
    """ Tests  """
    assert is_palindrome(1221) == 1
    assert is_palindrome(-101) == 0
    assert is_palindrome(90) == 0

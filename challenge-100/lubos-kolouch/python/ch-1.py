#!/usr/bin/python
"""
#===============================================================================
#
#         FILE: ch-1.py
#
#        USAGE: ./ch-1.py
#
#  DESCRIPTION: Perl Weekly Challenge #100
#               Task 1
#       AUTHOR: Lubos Kolouch
#      CREATED: 02/20/2021 10:16:51 AM
#===============================================================================
"""
from time import strptime, strftime


def convert_time(inp_time):
    """ Convert the time as required """

    new_time = inp_time.replace(" ", "")
    parse_pattern = '%H:%M' if 'm' not in inp_time else '%I:%M%p'
    out_pattern = '%H:%M' if 'm' in inp_time else '%I:%M%p'

    conv_time = strptime(new_time, parse_pattern)
    return strftime(out_pattern, conv_time)


assert convert_time('05:15pm') == '17:15'
assert convert_time('05:15 pm') == '17:15'
assert convert_time('19:15') == '07:15PM'

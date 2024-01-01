#!/usr/bin/env python

import re

is_numeric = re.compile('^\d+$')

def alphanumValue(strval):
    if (is_numeric.match(strval)):
        return int(strval)
    return len(strval)

def maxAlphanumValue(alphanumstr):
    values = [ alphanumValue(x) for x in alphanumstr ]
    return max(values)

def comma_join(arr):
    return '"' + '", "'.join(arr) + '"'

def solution(alphanumstr):
    print(f'Input: @alphanumstr = ({comma_join(alphanumstr)})')
    maxValue = maxAlphanumValue(alphanumstr)
    print(f'Output: {maxValue}')

print('Example 1:')
solution(["perl", "2", "000", "python", "r4ku"])

print('\nExample 2:')
solution(["001", "1", "000", "0001"])
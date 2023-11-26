#!/usr/bin/env python

from functools import reduce

def makeAcronym(str_list):
    # add empty string to beginning of list
    str_list = [''] + str_list
    acronym = reduce(lambda a, b: a + b[0], str_list)
    return acronym.lower()

def solution(chk, str_list):
    as_list = '"' + '", "'.join(str_list) + '"'
    print(f'Input: @str = ({as_list})')
    print(f'       $chk = "{chk}"')
    acronym = makeAcronym(str_list)
    same = 'true' if acronym == chk else 'false'
    print(f'Output: {same}')

print('Example 1:')
solution("ppp", ["Perl", "Python", "Pascal"])

print('\nExample 2:')
solution("rp", ["Perl", "Raku"])

print('\nExample 3:')
solution("oac", ["Oracle", "Awk", "C"])
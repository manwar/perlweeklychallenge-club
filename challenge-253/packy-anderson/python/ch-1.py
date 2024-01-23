#!/usr/bin/env python

def splitOnSeparator(words, separator):
    output = []
    for str in words:
        output.extend(
            list(filter(lambda w: w > "", str.split(separator)))
        )
    return output

def comma_join(arr):
    return '"' + '", "'.join(arr) + '"'

def solution(words, separator):
    print(f'Input: @words = ({comma_join(words)})')
    print(f'       $separator = "{separator}"')
    output = splitOnSeparator(words, separator)
    print(f'Output: {comma_join(output)}')

print('Example 1:')
solution(["one.two.three","four.five","six"], '.')

print('\nExample 2:')
solution(['$perl$$', '$$raku$'], '$')

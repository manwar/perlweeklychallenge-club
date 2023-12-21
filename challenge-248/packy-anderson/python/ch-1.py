#!/usr/bin/env python

def shortestDistance(s, c):
    # split the string into an array of characters
    strchar = list(s)
    # find the positions of the target char
    pos = [ x for x in range(len(s)) if strchar[x] == c ]

    output = []
    for i in range(len(s)):
        # find the distances
        distance = [ abs(i - p) for p in pos ]
        # find the minimum distance
        output.append(  min(distance) )
    return output

def comma_join(arr):
    return ','.join(map(lambda i: str(i), arr))

def solution(s, c):
    print(f'Input: $str = "{s}", $char = "{c}"')
    output = shortestDistance(s, c)
    print(f'Output: ({comma_join(output)})')

print('Example 1:')
solution("loveleetcode", "e")

print('\nExample 2:')
solution("aaab", "b")
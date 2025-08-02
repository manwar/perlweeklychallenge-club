#!/usr/bin/env python

from collections import Counter

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def conjunction(ints):
    if len(ints) < 2:
        return(ints)
    elif len(ints) == 2:
        return(f'{ints[0]} and {ints[1]}')
    else:
        last = ints.pop(-1)
        l = comma_join(ints)
        return(f'{l}, and {last}')

def maxFrequency(ints):
    freq = Counter(ints)
    maxFreq = max(freq.values())
    atMax = []
    for i in sorted(freq.keys()):
        if freq[i] == maxFreq:
            atMax.append(i)
    numList  = conjunction(atMax)
    elements = "elements" if len(atMax) > 1 else "element"
    have     = "have"     if len(atMax) > 1 else "has"
    explain = (
        f"The maximum frequency is {maxFreq}.\n" +
        f"The {elements} {numList} {have} " +
        f"the maximum frequency."
    )
    return (maxFreq * len(atMax), explain)

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    count, explain = maxFrequency(ints)
    print(f'Output: {count}\n\n{explain}')

print('Example 1:')
solution([1, 2, 2, 4, 1, 5])

print('\nExample 2:')
solution([1, 2, 3, 4, 5])

#!/usr/bin/env python

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def completeDays(hours):
    pairs = []
    for i in range(len(hours) - 1):
        for j in range(i+1, len(hours)):
            if ( hours[i] + hours[j] ) % 24 == 0:
                pairs.append([ hours[i], hours[j] ])

    explain = ""
    i = 1
    for p in pairs:
        explain += f"\nPair {i}: ({comma_join(p)})"
        i += 1

    return len(pairs), explain

def solution(hours):
    print(f'Input: @hours = ({comma_join(hours)})')
    count, explain = completeDays(hours)
    print(f'Output: {count}\n{explain}')

print('Example 1:')
solution([12, 12, 30, 24, 24])

print('\nExample 2:')
solution([72, 48, 24, 5])

print('\nExample 3:')
solution([12, 18, 24])

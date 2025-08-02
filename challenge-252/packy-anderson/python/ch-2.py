#!/usr/bin/env python

def uniqueSumZero(n):
    zero_sum_list = []
    x = 1
    while n > 0:
        if (n % 2 == 1): # n is odd
            zero_sum_list.append(0)
            n -= 1
        else: # n is even
            zero_sum_list.append(x * -1)
            zero_sum_list.append(x)
            x += 1
            n -= 2
    zero_sum_list.sort()
    return zero_sum_list

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(n):
    print(f'Input: $n = {n}')
    zero_sum_list = uniqueSumZero(n)
    print(f'Output: ({comma_join(zero_sum_list)})')

print('Example 1:')
solution(5)

print('\nExample 2:')
solution(3)

print('\nExample 3:')
solution(1)
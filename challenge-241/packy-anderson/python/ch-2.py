#!/usr/bin/env python

import math

def findPrimeFactors(num):
    factors = []
    while num % 2 == 0:
        factors.append(2)
        num /= 2

    for i in range(3, int(math.sqrt(num))):
        while num % i == 0:
            factors.append(i)
            num /= i

    if num > 2:
        factors.append(int(num))

    return factors

def sortByPrimeFactors(nums):
    primeFactors = {}
    # calculate the prime factors for each number
    for n in nums:
        primeFactors[n] = findPrimeFactors(n)
    # now sort the numbers
    sorted_list = sorted(nums,
                         key=lambda x: (
                             len(primeFactors[x]),
                             primeFactors[x]
                         )
                        )

    # now build the output
    factors = ''
    for n in sorted_list:
        factors += f'Prime factors of {n:2d} => '
        as_list = ', '.join(
            map(lambda i: str(i), primeFactors[n])
        )
        factors += as_list + '\n'

    return sorted_list, factors

def solution(nums):
    as_list = ', '.join(map(lambda i: str(i), nums))
    print(f'Input: @int = ({as_list})')
    sorted_list, factors = sortByPrimeFactors(nums)
    as_list = ', '.join(map(lambda i: str(i), sorted_list))
    print(f'Output: ({as_list})\n\n{factors}')

print('Example 1:')
solution([11, 8, 27, 4])

print('\nExample 2:')
solution([2, 4, 8, 12, 11])
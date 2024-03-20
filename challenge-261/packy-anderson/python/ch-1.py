#!/usr/bin/env python

def plus_join(arr):
    return ' + '.join(map(lambda i: str(i), arr))

def elementDigitSum(ints):
    elementSum = sum(ints)

    explain = f'Element Sum: {plus_join(ints)} = {elementSum}'

    # concatenate all the integers together into a single
    # string
    digitStr = ''.join([ str(i) for i in ints ])
    # loop over the individual digits
    digits = [ int(d) for d in digitStr ]
    digitSum = sum(digits)

    explain += "\n"
    explain += f'Digit Sum: {plus_join(digits)} = {digitSum}'

    absVal = abs(elementSum - digitSum)

    explain += "\n"
    explain += 'Absolute Difference: '
    explain += f'| {elementSum} - {digitSum} | = {absVal}'

    return (absVal, explain)

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    (sum, explain) = elementDigitSum(ints)
    print(f'Output: {sum}\n\n{explain}')

print('Example 1:')
solution([1,2,3,45])

print('\nExample 2:')
solution([1,12,3])

print('\nExample 3:')
solution([1,2,3,4])

print('\nExample 4:')
solution([236, 416, 336, 350])

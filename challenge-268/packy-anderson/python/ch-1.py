#!/usr/bin/env python

def magicNumber(x, y):
    xS = sorted(x)
    yS = sorted(y)
    magic = yS.pop(0) - xS.pop(0)
    while xS:
        if yS.pop(0) - xS.pop(0) != magic:
            return None; # no magic number
    return magic

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def solution(x, y):
    print(f'Input: @x = ({comma_join(x)})')
    print(f'       @y = ({comma_join(y)})')
    magic = magicNumber(x, y)
    if magic is None:
        print('Output: no magic number')
    else:
        print(f'Output: {magic}\n')
        print(f'@x = ({comma_join(x)})')
        magicStr = '  '.join(map(lambda i: str(magic), x))
        print(f'   +  {magicStr}')
        yStr = ', '.join(map(lambda i: str(i+magic), x))
        print(f'@y = ({yStr}')

print('Example 1:')
solution([3, 7, 5], [9, 5, 7])

print('\nExample 2:')
solution([1, 2, 1], [5, 4, 4])

print('\nExample 3:')
solution([2], [5])

print('\nExample 4:')
solution([1, 2], [4, 2])
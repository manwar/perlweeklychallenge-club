#!/usr/bin/env python

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def specialElementIndices(n):
    return list( filter(lambda x: n % x == 0, range(1, n+1)) )

def english_list (strlist):
    # given a list, join it in a way that makes sense
    # to english speakers
    last = strlist.pop(-1) # last element in array
    if (len(strlist) == 0):
        # using an array in a scalar context returns
        # the number of elements in the array

        # there was only one element in the list
        return last

    joined = ',\n'.join(strlist)
    if (len(strlist) > 1):
        # if there's more than element, add an Oxford comma
        joined += ','

    return f'{joined} and\n{last}'

def specialNumberSquareSum(ints):
    n = len(ints)

    # find the list of indices for "special" numbers
    specialIndices = specialElementIndices(n)
    count = len(specialIndices)
    explain_list = [
        f"$ints[{x}] since {x} divides {n}"
        for x in specialIndices
    ]
    explain = (
        "There are exactly $count special elements " +
        "in the given array:\n" + english_list(explain_list)
    )

    # find the special numbers themselves
    special = [ ints[x - 1] for x in specialIndices ]

    # find the sum of the squares
    sumval = sum([ x ** 2 for x in special ])

    explain += '\nHence, the sum of the squares of all special '
    explain += 'elements of given array:\n'
    explain += ' + '.join(map(lambda x: f'{x} * {x}', special))
    explain += f' = {sumval}'

    return (
        sumval,
        explain
    )

def solution(ints):
    print(f'Input: @ints = ({comma_join(ints)})')
    (sumval, explain) = specialNumberSquareSum(ints)
    print(f'Output: {sumval}')
    print('')
    print(explain)

print('Example 1:')
solution([1, 2, 3, 4])

print('\nExample 2:')
solution([2, 7, 1, 19, 18, 3])
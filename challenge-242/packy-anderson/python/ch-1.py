#!/usr/bin/env python

def comma_join(arr):
    return ', '.join(map(lambda i: str(i), arr))

def findMissing(source, target, output, explanation):
    # convert the target into a map with each element as keys
    targetMap = { x: 1 for x in target }

    # see which elements in the source are not in the target
    missing = []
    for elem in source:
        if not elem in targetMap:
            missing.append(elem)

    # format output explaining what we found
    explanation += "\n(" + comma_join(source) + ") has "
    explanation += str(len(missing))
    explanation += ' member ' if len(missing) == 1 \
                              else ' members '
    if (len(missing) > 0):
        explanation += '(' + comma_join(missing) + ') '
        output.append(set(missing))
    explanation += 'missing from the array '
    explanation += '(' + comma_join(target) + ')'
    return explanation


def findSolution(arr1, arr2, output):
    explanation = ''
    explanation = findMissing(arr1, arr2, output, explanation)
    explanation = findMissing(arr2, arr1, output, explanation)
    return explanation


def solution(arr1, arr2):
    print(f'Input: @arr1 = ({comma_join(arr1)})')
    print(f'       @arr2 = ({comma_join(arr2)})')

    output = []
    explanation = findSolution(arr1, arr2, output)
    formatted_subarray = []
    for subarray in output:
        formatted_subarray.append('[' + comma_join(subarray) + ']')
    print(f'Output: ({comma_join(formatted_subarray)})')
    print(explanation)


print('Example 1:')
solution([1, 2, 3], [2, 4, 6])

print('\nExample 2:')
solution([1, 2, 3, 3], [1, 1, 2, 2])
#!/usr/bin/env python
""" Perl Weekly challenge 075 Task 2 - Largest histogram """


def printHistogram(histogram):
    """ print the histogram """

    hist_max = max(histogram)

    for i in range(hist_max, 0, -1):
        my_str = str(i)

        for bar in histogram:
            my_str += '#' if bar >= i else ' '

        print(my_str)

    my_str = '_'
    for _ in histogram:
        my_str += '_'

    print(my_str)

    my_str = ' '
    for item in histogram:
        my_str += str(item)

    print(my_str)

def largestRectangle(histogram):
    stack = list()
    max_area = 0
    index = 0

    while index < len(histogram):
        if (not stack) or (histogram[stack[-1]] <= histogram[index]):
            stack.append(index)
            index += 1
        else:
            top_of_stack = stack.pop()
            area = (histogram[top_of_stack] * ((index - stack[-1] - 1)
                 if stack else index))

            max_area = max(max_area, area)

    while stack:
 
        top_of_stack = stack.pop()

        area = (histogram[top_of_stack] * ((index - stack[-1] - 1)
                if stack else index))

        max_area = max(max_area, area)

    printHistogram(histogram)

    return max_area


assert largestRectangle([2, 1, 4, 5, 3, 7]) == 12
assert largestRectangle([3, 2, 3, 5, 7, 5]) == 15


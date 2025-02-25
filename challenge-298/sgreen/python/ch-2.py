#!/usr/bin/env python3

import sys


def right_interval(intervals: list[list[int]]) -> list:
    """For each interval(pair of start and end values) find the right interval

    Args:
        intervals: A list of list, where each value is the start and end)

    Returns:
        list: The best interval for each interval, or -1 if there is none
    """
    best_intervals = []
    for i in intervals:
        # Calculate the right interval for this interval
        end_i = i[1]
        lowest_j = None
        index_j = -1
        for j in range(len(intervals)):
            start_j = intervals[j][0]
            if start_j >= end_i:
                if lowest_j is None or start_j < lowest_j:
                    # This is the best matching interval
                    lowest_j = start_j
                    index_j = j

        best_intervals.append(index_j)

    return best_intervals


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]

    # Convert integers into pairs
    intervals = []
    for i in range(0, len(array), 2):
        intervals.append([array[i], array[i+1]])

    # Run the query
    result = right_interval(intervals)
    print(result)


if __name__ == '__main__':
    main()

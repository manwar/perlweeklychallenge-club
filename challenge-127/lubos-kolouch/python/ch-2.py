#!python
# ===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: The Weekly Challenge #127
#               Task 2 - Conflict Intervals
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 08/27/2021 11:45:07 AM
# ===============================================================================

def check_intervals(what):
    """ Check the intervals overlap """

    intervals = []
    result = []

    for interval in what:
        for seen_interval in intervals:
            if ((interval[1] > seen_interval[0]) and (interval[0] <= seen_interval[0])) or \
             ((interval[0] < seen_interval[1]) and (interval[0] >= seen_interval[0])):
                result.append(interval)
                break

        intervals.append(interval)

    return result


assert check_intervals([[1, 4], [3, 5], [6, 8], [12, 13], [3, 20]]) == [[3, 5], [3, 20]]
assert check_intervals([[3, 4], [5, 7], [6, 9], [10, 12], [13, 15]]) == [[6, 9]]

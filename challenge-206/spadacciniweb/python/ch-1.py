# Task 1: Shortest Time
# Submitted by: Mohammad S Anwar
# 
# You are given a list of time points, at least 2, in the 24-hour clock format HH:MM.
# Write a script to find out the shortest time in minutes between any two time points.
#
# Example 1
# Input: @time = ("00:00", "23:55", "20:00")
# Output: 5
# 
# Since the difference between "00:00" and "23:55" is the shortest (5 minutes).
# 
# Example 2
# Input: @array = ("01:01", "00:50", "00:57")
# Output: 4
# 
# Example 3
# Input: @array = ("10:10", "09:30", "09:00", "09:55")
# Output: 15

import re
import sys
from itertools import combinations

def get_minutes(t):
    return 60 * int(t[0:2]) + int(t[3:5])

def get_diff_minutes(m1, m2):
    res = abs(m1-m2)

    if (res >= 720):        # 12h * 60 = minutes
        return 1440 - res   # 24h * 60 = minutes
    return res

if __name__ == "__main__":
    input = sys.argv[1:]
    if (len(input) < 2
        or
        len(list(filter(lambda x: re.search(r'\d\d:\d\d', x), input))) != len(input)
        or
        len(list(filter(lambda x: x > '24:00', input))) != 0 ):
        sys.exit("Input error\n")

    minutes = [get_minutes(x) for x in input]
    comb = combinations(range(len(input)), 2)
    h_minutes = {
        'val': None,
        'pair': None
    }

    for pair in list(comb):
        diff_minutes = get_diff_minutes(minutes[pair[0]], minutes[pair[1]])
        if h_minutes['val'] == None or h_minutes['val'] > diff_minutes:
            h_minutes['val'] = diff_minutes
            h_minutes['pair'] = pair
    
    print(h_minutes['val'])
    print("Since the difference between \"{:s}\" and \"{:s}\" is the shortest ({:d} minutes).".format(input[ h_minutes['pair'][0] ], input[ h_minutes['pair'][1] ], h_minutes['val'] ))

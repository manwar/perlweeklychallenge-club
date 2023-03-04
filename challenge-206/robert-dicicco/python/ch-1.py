#!/usr/bin/env python
'''
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-02=28
Challenge 206 Shortest Times ( Python )
---------------------------------------
'''
from itertools import combinations

times = [["00:00", "23:55", "20:00"],["01:01", "00:50", "00:57"],["10:10", "09:30", "09:00", "09:55"]]

for tm in times:
    print("Input: @array = ", tm)
    shortest = 1441
    minutes = []
    absval = 0

    for n in range(len(tm)):
        time_split = tm[n].split(':')
        hrs = int(time_split[0])
        mins = int(time_split[1])
        time_in_mins = (hrs * 60) + mins
        if (time_in_mins == 0):
            time_in_mins = 1440
        minutes.append(time_in_mins)

    ax = combinations(minutes, 2)
    for res in list(ax):
        absval = abs(res[0] - res[1])
        if (absval < shortest):
            shortest = absval

    print(f"Output: {shortest}\n")

'''
---------------------------------------
SAMPLE OUTPUT
python .\ShortestTime.py
Input: @array =  ['00:00', '23:55', '20:00']
Output: 5

Input: @array =  ['01:01', '00:50', '00:57']
Output: 4

Input: @array =  ['10:10', '09:30', '09:00', '09:55']
Output: 15
---------------------------------------
'''

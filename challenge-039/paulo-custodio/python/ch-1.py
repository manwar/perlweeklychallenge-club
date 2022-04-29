#!/usr/bin/env python3

# Challenge 039
#
# TASK #1
# A guest house had a policy that the light remain ON as long as the at least
# one guest is in the house. There is guest book which tracks all guest in/out
# time. Write a script to find out how long in minutes the light were ON.
# Guest Book
# 1) Alex    IN: 09:10 OUT: 09:45
# 2) Arnold  IN: 09:15 OUT: 09:33
# 3) Bob     IN: 09:22 OUT: 09:55
# 4) Charlie IN: 09:25 OUT: 10:05
# 5) Steve   IN: 09:33 OUT: 10:01
# 6) Roger   IN: 09:44 OUT: 10:12
# 7) David   IN: 09:57 OUT: 10:23
# 8) Neil    IN: 10:01 OUT: 10:19
# 9) Chris   IN: 10:10 OUT: 11:00

from datetime import datetime
from operator import itemgetter

def ptime(str):
    return datetime.strptime(str, "%H:%M")

# on/off times
times = [
    {'on':ptime('09:10'), 'off':ptime('09:45')},
    {'on':ptime('09:15'), 'off':ptime('09:33')},
    {'on':ptime('09:22'), 'off':ptime('09:55')},
    {'on':ptime('09:25'), 'off':ptime('10:05')},
    {'on':ptime('09:33'), 'off':ptime('10:01')},
    {'on':ptime('09:44'), 'off':ptime('10:12')},
    {'on':ptime('09:57'), 'off':ptime('10:23')},
    {'on':ptime('10:01'), 'off':ptime('10:19')},
    {'on':ptime('10:10'), 'off':ptime('11:00')},
]

# sort by on time
times = sorted(times, key=itemgetter('on', 'off'))

# merge times
def merge_times(times):
    times = iter(times)
    merged = next(times).copy()
    for entry in times:
        start, end = entry['on'], entry['off']
        if start <= merged['off']:
            # overlapping, merge
            merged['off'] = max(merged['off'], end)
        else:
            # distinct; yield merged and start a new copy
            yield merged
            merged = entry.copy()
    yield merged

# iterate through merged intervals
minutes = 0
for entry in merge_times(times):
    delta = entry['off'] - entry['on']
    minutes += delta.total_seconds()/60

print(int(minutes))

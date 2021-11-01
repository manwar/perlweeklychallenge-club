#!/usr/bin/env python3

# TASK #2 > Minimum Platforms
# Submitted by: Mohammad S Anwar
# You are given two arrays of arrival and departure times of trains at a railway
# station.
#
# Write a script to find out the minimum number of platforms needed so that no
# train needs to wait.
#
# Example 1:
# Input: @arrivals   = (11:20, 14:30)
#        @departures = (11:50, 15:00)
# Output: 1
#
#     The 1st arrival of train is at 11:20 and this is the only train at the
#     station, so you need 1 platform.
#     Before the second arrival at 14:30, the first train left the station at
#     11:50, so you still need only 1 platform.
# Example 2:
# Input: @arrivals   = (10:20, 11:00, 11:10, 12:20, 16:20, 19:00)
#        @departures = (10:30, 13:20, 12:40, 12:50, 20:20, 21:20)
# Output: 3
#
#     Between 12:20 and 12:40, there would be at least 3 trains at the station,
#     so we need minimum 3 platforms.

import time

def parse_arrivals_departures():
    def parse_times():
        line = input()
        times = [time.strptime(x, "%H:%M") for x in line.split()]
        return times

    arrivals = parse_times()
    departures = parse_times()
    stops = []
    while len(arrivals) > 0 and len(departures) > 0:
        stops.append([arrivals.pop(0), departures.pop(0)])
    return stops

def allocate_platforms(stops):
    platforms = []

    def platform_free(platform, s, e):
        for stop in platform:
            if (s >= stop[0] and s <  stop[1]) or \
               (e >= stop[0] and e <  stop[1]) or \
               (s <  stop[0] and e >= stop[1]):
                return False
        return True

    def allocate_stop(s, e):
        for platform in platforms:
            if platform_free(platform, s, e):
                platform.append([s, e])
                return
        platforms.append([[s, e]])

    for stop in stops:
        allocate_stop(stop[0], stop[1])
    return platforms

stops = parse_arrivals_departures()
platforms = allocate_platforms(stops)
print(len(platforms))

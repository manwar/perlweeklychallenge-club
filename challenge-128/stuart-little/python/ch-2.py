#!/usr/bin/env python

# run <script> <starting arrivals followed by departures, all space-separated>

import sys

times = sorted([ (x,y % (len(sys.argv[1:])//2)) for (x,y) in zip(sys.argv[1:], range(len(sys.argv[1:])))], key=lambda x: x[0])
sol=0
station=[0] * (len(sys.argv[1:])//2)

for tm in times:
    station[tm[1]]^=1
    if sum(station) > sol:
        sol = sum(station)

print(sol)

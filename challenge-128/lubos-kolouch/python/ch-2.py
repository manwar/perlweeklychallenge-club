#!/usr/bin/env python
# -*- coding: utf-8 -*-


def min_platforms(arrivals, departures):
    arrivals.sort()
    departures.sort()

    platforms = result = 1
    i = j = 1

    while i < len(arrivals) and j < len(departures):
        if arrivals[i] <= departures[j]:
            platforms += 1
            i += 1
        elif arrivals[i] > departures[j]:
            platforms -= 1
            j += 1

        result = max(result, platforms)

    return result


arrivals = ["10:20", "11:00", "11:10", "12:20", "16:20", "19:00"]
departures = ["10:30", "13:20", "12:40", "12:50", "20:20", "21:20"]

print(min_platforms(arrivals, departures))

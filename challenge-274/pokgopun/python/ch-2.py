### https://theweeklychallenge.org/blog/perl-weekly-challenge-274/
"""

Task 2: Bus Route

Submitted by: [58]Peter Campbell Smith
     __________________________________________________________________

   Several bus routes start from a bus stop near my home, and go to the
   same stop in town. They each run to a set timetable, but they take
   different times to get into town.

   Write a script to find the times - if any - I should let one bus leave
   and catch a strictly later one in order to get into town strictly
   sooner.

   An input timetable consists of the service interval, the offset within
   the hour, and the duration of the trip.

Example 1

Input: [ [12, 11, 41], [15, 5, 35] ]
Output: [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47]

Route 1 leaves every 12 minutes, starting at 11 minutes past the hour (so 11, 23
, ...) and takes 41 minutes. Route 2 leaves every 15 minutes, starting at 5 minu
tes past (5, 20, ...) and takes 35 minutes.

At 45 minutes past the hour I could take the route 1 bus at 47 past the hour, ar
riving at 28 minutes past the following hour, but if I wait for the route 2 bus
at 50 past I will get to town sooner, at 25 minutes past the next hour.

Example 2

Input: [ [[12, 3, 41], [15, 9, 35], [30, 5, 25] ]
Output: [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51
, 55, 56, 57, 58, 59 ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23rd June 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def busRoute(sch):
    t2d = dict()
    for offst, strt, drtn in sch:
        for t in range(strt, 60, offst):
            if t2d.get(t) == None or drtn < t2d[t]:
                t2d[t] = drtn
    tt = list()
    t2d = sorted(t2d.items())
    for i in range(len(t2d)):
        t0, t1, t2 = t2d[i-2][0], t2d[i-1][0], t2d[i][0]
        gap0 = (t1 - t0) % 60
        gap = (t2 - t1) % 60
        dur1 = t2d[i-1][1]
        dur2 = t2d[i][1]
        if gap + dur2 < dur1:
            for g in range(gap0):
                tt.append((t0 + g + 1) % 60)
    tt.sort()
    return tt

import unittest

class TestBusRoute(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ((12,11,41),(15,5,35)): [36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47],
                ((12, 3, 41), (15, 9, 35), (30, 5, 25)): [ 0, 1, 2, 3, 25, 26, 27, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51 , 55, 56, 57, 58, 59 ],
                }.items():
            self.assertEqual(busRoute(inpt),otpt)

unittest.main()

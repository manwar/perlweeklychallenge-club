#!/usr/bin/env python

def routeTimes(route):
  (interval, start, duration) = route
  times = {}
  while (start < 60 + interval):
    times[start] = start + duration
    start += interval
  return times

def faster(routes):
  # find the arrival times for each route's departures
  times = {}
  for route in routes:
    for start, arrive in routeTimes(route).items():
      if (start in times) and (times[start] > arrive):
        # this departure for this route will arrive sooner than
        # the departure for the earlier route, keep this one!
        times[start] = arrive
      elif (start not in times):
        # no route we've seen has a departure at this time
        times[start] = arrive

  # now look at all the departures and see if there are
  # later departures with earlier arrivals
  bad_starts = []
  starts = sorted(times.keys(), key=int)
  for pos, start in enumerate(starts):
    for i in starts[pos+1:]:
      if (times[i] < times[start]):
        # we found a later departure with an earlier arrival!
        if start not in bad_starts:
          bad_starts.append(start)

  # now determine which minutes of the hour we should say
  # "skip the next bus and take the later one"
  skip = []
  for min in range(60):
    if (starts and bad_starts and starts[0] == bad_starts[0]):
      # we're in a bad window!
      skip.append(min)
    if (starts and starts[0] == min):
      starts.pop(0) # remove the start time
    if (bad_starts and bad_starts[0] == min):
      bad_starts.pop(0) # remove the bad start time

  return skip

def comma_join(arr):
  return ', '.join(map(lambda i: str(i), arr))

def routeJoin(routes):
  out = []
  for route in routes:
    out.append('[' + comma_join(route) + ']')
  return '[ ' + ', '.join(out) + ' ]'

def solution(routes):
  print(f'Input: {routeJoin(routes)}')
  print(f'Output: [{comma_join(faster(routes))}]')

print('Example 1:')
solution([ [12, 11, 41], [15, 5, 35] ])

print('\nExample 2:')
solution([ [12, 3, 41], [15, 9, 35], [30, 5, 25] ])

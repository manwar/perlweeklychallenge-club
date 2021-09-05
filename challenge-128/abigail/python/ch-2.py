#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import re

def get_time (time):
    hours, minutes = map (lambda x: int (x), time . split (":"))
    return (60 * hours + minutes)

def read_times ():
    return (list (map (get_time,
                       re . findall (r'[0-9][0-9]:[0-9][0-9]', input ()))))

arrivals   = read_times ()
departures = read_times ()

trains = [0] * (24 * 60)

for i in range (len (arrivals)):
    arrival   = arrivals [i]
    departure = departures [i]
    for i in range (arrival, departure + 1):
        trains [i] = trains [i] + 1
    if departure < arrival:
        for i in range (0, departure + 1):
            trains [i] = trains [i] + 1
        for i in range (arrival, 24 * 60):
            trains [i] = trains [i] + 1

print (max (trains))

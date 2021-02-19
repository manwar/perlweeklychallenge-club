#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as python ch-1.py < input-file
#

import fileinput
import re


for line in fileinput . input ():
    #
    # Parse input
    #
    hour, minute, ampm = re . compile (r'([0-9]+):([0-9]+)\s*([ap]?)') \
                            . match (line)                             \
                            . groups ()
    #
    # Make sure we have integers
    #
    hour   = int (hour)
    minute = int (minute)

    #
    # Calculate new AM/PM marker
    #
    new_ampm = ""
    if ampm == "":
        if hour >= 12:
            new_ampm = "pm"
        else:
            new_ampm = "am"

    #
    # Calculate new hour
    #
    hour = hour % 12
    if ampm == "" and hour == 0:
        hour = 12
    if ampm == "p":
        hour = hour + 12

    #
    # Print result
    #
    print ("{:02d}:{:02d}{:s}" . format (hour, minute, new_ampm))

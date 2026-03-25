#!/opt/homebrew/bin/python3

import sys
import re

for line in sys . stdin:
    [hours, minutes] = line . strip () . split (":")
    h_times = 0
    m_times = 0

    if   hours == "??":
         h_times = 24
    elif re . match (r"^\?[0-3]$",      hours):
         h_times =  3
    elif re . match (r"^\?[4-9]$",      hours):
         h_times =  2
    elif re . match (r"[01]\?$",        hours):
         h_times = 10
    elif hours == "2?":
         h_times =  4
    elif re . match (r"[01][0-9]$",     hours):
         h_times =  1
    elif re . match (r"2[0-3]$",        hours):
         h_times = 10

    if   minutes == "??":
         m_times = 60
    elif re . match (r"^\?[0-9]$",    minutes):
         m_times =  6
    elif re . match (r"^[0-5]\?$",    minutes):
         m_times = 10
    elif re . match (r"^[0-5][0-9]$", minutes):
         m_times =  1

    print (h_times * m_times)


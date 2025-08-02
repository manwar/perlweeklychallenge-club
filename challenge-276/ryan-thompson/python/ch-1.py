#!/usr/bin/env python3
#
# ch-1.py - Complete Day
#
# 2024 Ryan Thompson <rjt@cpan.org>

def complete_day(hours):
    count = 0
    for i, m in enumerate(hours):
        for n in filter(lambda n: ((m + n) % 24 == 0), hours[i+1:]):
            count += 1

    return(count)

# Examples
print(complete_day([12, 12, 30, 24, 24]))   # 2
print(complete_day([72, 48, 24, 5]))        # 3
print(complete_day([12, 18, 24]))           # 0
print(complete_day([]))                     # 0 

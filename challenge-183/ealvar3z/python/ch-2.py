# -*- coding: utf-8 -*-
#!/usr/bin/env python3
"""
Created on Wed Oct 12 20:20:12 2022

@author: Erly.Alvarez

You are given two dates, $date1 and $date2 in the format YYYY-MM-DD.

Write a script to find the difference between the given dates in terms on years and days only.

Example 1
Input: $date1 = '2019-02-10'
       $date2 = '2022-11-01'
Output: 3 years 264 days

Example 2
Input: $date1 = '2020-09-15'
       $date2 = '2022-03-29'
Output: 1 year 195 days

Example 3
Input: $date1 = '2019-12-31'
       $date2 = '2020-01-01'
Output: 1 day
"""
import argparse
from datetime import datetime
from dateutil.relativedelta import relativedelta

if __name__ == '__main__':
    p = argparse.ArgumentParser(description='Perl Weekly Challenge 183')
    p.add_argument(
            "-f", "--fro",
            nargs="?",
            type=str,
            default='2019-12-31')
    p.add_argument(
            "-t", "--to",
            nargs="?",
            type=str,
            default='2020-01-01')
    args = p.parse_args()
    
    d1 = datetime.fromisoformat(args.fro)
    d2 = datetime.fromisoformat(https://linkprotect.cudasvc.com/url?a=https%3a%2f%2fargs.to&c=E,1,CM-DuVk1S39O5Ybvxenmk8X7HsnV5bAL9qY47NIuQKTFBxlSB7AVPv5yucJP4ma3nl4GTZ7atCkmpiNcoB8EMtn4ejlFTBqZ84GFQC59FUQi5zCH3Q,,&typo=1)
    
    d = relativedelta(d2, d1)
    
    if d.years < 1:
        print(f"{d.days} day")
    elif d.years >= 1 and d.days >= 1:
        print(f"{d.years} years {d.days} day")
    else:
        print(f"{d.years} years {d.days} days")

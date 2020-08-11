#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py  
#
#  DESCRIPTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-048/
#
#               Palindrome Dates
#
#               Write a script to print all Palindrome Dates between 2000 and 2999. The format of date is mmddyyyy. For example, the first one was on October 2, 2001 as it is represented as 10022001.
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 02/22/2020 10:11:25 AM
#     REVISION: ---
#===============================================================================

from datetime import date, timedelta

dt = date(2000,1,1)

while dt.year < 3000:
    dt += timedelta(days=1)
    if dt.strftime("%m%d%Y") == dt.strftime("%m%d%Y")[::-1]:
        print(dt)

